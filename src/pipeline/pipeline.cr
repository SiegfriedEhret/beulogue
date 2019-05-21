require "html"
require "markdown"
require "xml"
require "../objects/*"
require "../pipeline/*"

module Beulogue
  module Pipeline
    class Pipeline
      def initialize(cwd : String, @config : BeulogueConfig)
        @cwd = Path[cwd]
        @renderer = Renderer.new(@config)
      end

      def runSingleLanguage(files : Array(Path))
        lang = @config.languages[0]

        Beulogue.logger.debug "Pages for lang #{lang}, #{files}"

        elapsed_time = Time.measure do
          pages = files.map do |f|
            content = Beulogue::Pipeline::Converter.convert(f, "", @cwd)
            Beulogue::Pipeline::Page.write(@renderer, content)
          end

          Beulogue::Pipeline::List.write(@renderer, @config, pages, "")
          Beulogue::Pipeline::RSS.write(@config, pages, "")
        end

        Beulogue.logger.info "Site for language #{lang} (#{files.size} pages) built in #{elapsed_time.total_milliseconds.round(2)}ms."
      end

      def runMultiLanguage(files : Array(Path))
        filesPerLanguage = groupPerLanguage(files, @config.languages)

        filesPerLanguage.each do |lang, filesForLanguage|
          Beulogue.logger.debug "Pages for lang #{lang}, #{filesForLanguage}"

          elapsed_time = Time.measure do
            contents = filesForLanguage.map do |f|
              Beulogue.logger.debug "Processing #{f}"
              Beulogue::Pipeline::Converter.convert(f, lang, @cwd)
            end

            pages = contents.map do |content|
              Beulogue::Pipeline::Page.write(@renderer, content)
            end

            Beulogue::Pipeline::List.write(@renderer, @config, pages, lang)
            Beulogue::Pipeline::RSS.write(@config, pages, lang)
          end

          Beulogue.logger.info "Site for language #{lang} (#{filesForLanguage.size} pages) built in #{elapsed_time.total_milliseconds.round(2)}ms."
        end

        Beulogue::Pipeline::Redirection.write(@config)
      end

      def run
        if @config.targetDir.nil?
          Beulogue.logger.fatal "Can't find target directory"

          exit
        else
          files = Beulogue::Pipeline::Walker.run(@cwd)

          if @config.languages.size > 1
            self.runMultiLanguage files
          else
            self.runSingleLanguage files
          end
        end
      end

      private def groupPerLanguage(files : Array(Path), languages : Array(String))
        files.group_by { |f| languages.find { |lang| f.to_s.ends_with?(".#{lang}.md") } || languages[0] }
      end
    end
  end
end
