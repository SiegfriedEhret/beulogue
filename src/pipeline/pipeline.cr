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
            begin
              content = Beulogue::Pipeline::Converter.convert(f, "", lang, @cwd)
              Beulogue::Pipeline::Page.write(@renderer, content, BeulogueMultilang.new)
            rescue ex
              Beulogue.logger.error "Failed to process #{f}"
              Beulogue.logger.debug ex.message
              nil
            end
          end

          realPages = pages.compact
          Beulogue::Pipeline::List.write(@renderer, @config, realPages.select { |p| !p.orphan }, "", lang)
          Beulogue::Pipeline::RSS.write(@config, realPages, "")
        end

        Beulogue.logger.info "Site for language #{lang} (#{files.size} pages) built in #{elapsed_time.total_milliseconds.round(2)}ms."
      end

      def runMultiLanguage(files : Array(Path))
        filesPerLanguage = groupPerLanguage(files, @config.languages)
        multiLang = BeulogueMultilang.new

        times = Hash(String, Float64).new

        contentsPerLanguage = Hash(String, Array(Beulogue::BeulogueContent)).new
        filesPerLanguage.each do |lang, filesForLanguage|
          elapsed_time = Time.measure do
            contents = filesForLanguage.map do |f|
              begin
                content = Beulogue::Pipeline::Converter.convert(f, lang, lang, @cwd)
              rescue ex
                Beulogue.logger.error "Failed to process #{f}"
                Beulogue.logger.debug ex.message
              end

              if !content.nil?
                multiLang.add content.base, lang, content.toURL
              end

              content
            end
            contentsPerLanguage[lang] = contents.compact
          end

          times[lang] = elapsed_time.total_milliseconds
        end

        contentsPerLanguage.each do |lang, contents|
          Beulogue.logger.debug "Pages for lang #{lang}, #{contents}"

          elapsed_time = Time.measure do
            pages = contents.map do |content|
              Beulogue::Pipeline::Page.write(@renderer, content, multiLang)
            end

            Beulogue::Pipeline::List.write(@renderer, @config, pages.select { |p| !p.orphan }, lang, lang)
            Beulogue::Pipeline::RSS.write(@config, pages, lang)
          end

          times[lang] = times[lang] + elapsed_time.total_milliseconds

          Beulogue.logger.info "Site for language #{lang} (#{contents.size} pages) built in #{times[lang].round(2)}ms."
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
