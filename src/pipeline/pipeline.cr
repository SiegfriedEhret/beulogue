require "html"
require "markd"
require "xml"
require "../objects/content"
require "../objects/front-matter"
require "../objects/multilang"
require "../objects/page"
require "../objects/renderer"
require "./converter"
require "./writer-list"
require "./writer-page"
require "./writer-redirection"
require "./writer-rss"
require "./writer-tag"
require "./walker"

module Beulogue
  module Pipeline
    class Pipeline
      def initialize(wd : String, @config : BeulogueConfig)
        @wd = Path[wd]
        @renderer = Renderer.new(@config)
      end

      def processTags(pages : Array(BeuloguePage), lang : String, contentLang : String)
        tags = pages.map { |p| p.tags }.flatten.compact.uniq
        Log.debug { "Tags #{tags.inspect}" }
        tags.each do |t|
          Beulogue::Pipeline::Tag.write(@renderer, @config, pages.select { |p| p.tags.includes? t }, t, lang, contentLang)
        end
      end

      def runSingleLanguage(files : Array(Path))
        lang = @config.languages[0]

        Log.debug { "Pages for lang #{lang}, #{files.size}" }
        multilang = BeulogueMultilang.new

        elapsed_time = Time.measure do
          pagesToWrite = files
            .map { |f| get_page(f, lang, multilang) }
            .compact
            .select { |p| !p.orphan }

          processTags(pagesToWrite, "", lang)

          Beulogue::Pipeline::List.write(@renderer, @config, pagesToWrite, "", lang, @config.dev_mode)
          Beulogue::Pipeline::RSS.write(@config, pagesToWrite, "")
        end

        Log.info { "Site for language #{lang} (#{files.size} pages) built in #{elapsed_time.total_milliseconds.round(2)}ms." }
      end

      private def get_page(f : Path, lang : String, multilang : BeulogueMultilang)
        begin
          content = Beulogue::Pipeline::Converter.convert(f, "", lang, @wd, @config.dev_mode)
          Beulogue::Pipeline::Page.write(@renderer, content, multilang)
        rescue ex
          Log.error { "Failed to process #{f}: #{ex.message}" }
          Log.debug { ex.message }
          nil
        end
      end

      def runMultiLanguages(files : Array(Path))
        filesPerLanguage = groupPerLanguage(files, @config.languages)
        multiLang = BeulogueMultilang.new

        times = Hash(String, Float64).new

        contentsPerLanguage = Hash(String, Array(Beulogue::BeulogueContent)).new
        filesPerLanguage.each do |lang, filesForLanguage|
          elapsed_time = Time.measure do
            contents = filesForLanguage.map do |f|
              begin
                content = Beulogue::Pipeline::Converter.convert(f, lang, lang, @wd, @config.dev_mode)
              rescue ex
                Log.error { "Failed to process #{f}: #{ex.message}" }
                Log.debug { ex.message }
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
          Log.debug { "Pages for lang #{lang}, #{contents.size}" }

          elapsed_time = Time.measure do
            pages = contents.map do |content|
              Beulogue::Pipeline::Page.write(@renderer, content, multiLang)
            end

            pagesToWrite = pages.compact.select { |p| !p.orphan }

            processTags(pagesToWrite, lang, lang)

            Beulogue::Pipeline::List.write(@renderer, @config, pagesToWrite, lang, lang, @config.dev_mode)
            Beulogue::Pipeline::RSS.write(@config, pagesToWrite, lang)
          end

          times[lang] = times[lang] + elapsed_time.total_milliseconds

          Log.info { "Site for language #{lang} (#{contents.size} pages) built in #{times[lang].round(2)}ms." }
        end

        Beulogue::Pipeline::Redirection.write(@config)
      end

      def run
        if @config.targetDir.nil?
          Log.fatal { "Can't find target directory" }

          exit
        else
          files = Beulogue::Pipeline::Walker.run(@wd)

          if @config.dev_mode == true
            begin
              files = files + Beulogue::Pipeline::Walker.run(@wd, "drafts")
            rescue
              Log.warn { "Can't open folder: drafts/" }
            end
          end

          Log.debug { files.inspect }

          if @config.languages.size > 1
            self.runMultiLanguages files
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
