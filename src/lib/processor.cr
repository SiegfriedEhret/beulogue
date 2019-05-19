require "html"
require "markdown"
require "xml"
require "../objects/*"

module Beulogue
  class Processor
    def initialize(cwd : String, @config : BeulogueConfig)
      @cwd = Path[cwd]
      @renderer = Renderer.new
    end

    def run
      if @config.targetDir.nil?
        Beulogue.logger.fatal "Can't find target directory"

        exit
      else
        files = walk(@cwd)

        if @config.languages.size > 1
          filesPerLanguage = splitPerLanguage(files, @config.languages)

          filesPerLanguage.each do |lang, filesForLanguage|
            Beulogue.logger.debug "Pages for lang #{lang}, #{filesForLanguage}"

            elapsed_time = Time.measure do
              pages = filesForLanguage.map do |f|
                Beulogue.logger.debug "Processing #{f}"
                writePage(convert(f, lang))
              end
              writeList(pages, lang)
              writeRss(pages, lang)
            end

            Beulogue.logger.info "Site for language #{lang} (#{filesForLanguage.size} pages) built in #{elapsed_time.total_milliseconds.round(2)}ms."
          end

          writeRedirection(@config.languages[0])
        else
          lang = @config.languages[0]

          Beulogue.logger.debug "Pages for lang #{lang}, #{files}"

          elapsed_time = Time.measure do
            pages = files.map { |f| writePage(convert(f, "")) }
            writeList(pages, "")
            writeRss(pages, "")
          end

          Beulogue.logger.info "Site for language #{lang} (#{files.size} pages) built in #{elapsed_time.total_milliseconds.round(2)}ms."
        end
      end
    end

    private def splitPerLanguage(files : Array(Path), languages : Array(String))
      files.group_by { |f| languages.find { |e| f.to_s.ends_with?(".#{e}.md") } || languages[0] }
    end

    private def walk(path : Path, extra : String = "content")
      contentPath = path.join(extra)
      d = Dir.new(contentPath.to_s)

      files = [] of Path

      d.each_child do |x|
        currentPath = contentPath.join(x)
        if File.directory?(currentPath.to_s)
          files.concat(self.walk(currentPath, ""))
        else
          files.push(currentPath)
        end
      end

      files
    end

    private def convert(fromPath : Path, lang : String)
      BeulogueObject.new(fromPath, lang, @cwd)
    end

    private def writeList(pages : Array(BeuloguePage), lang : String)
      targetDir = @config.targetDir

      if !targetDir.nil?
        model = BeulogueList.to_hash(@config, pages, lang)

        Beulogue.logger.debug "Writing list for lang #{lang}: #{model}"

        File.write(Path[targetDir].join(lang, "index.html").to_s,
          HTML.unescape(@renderer.renderList(model)))
      end
    end

    private def writeRss(pages : Array(BeuloguePage), lang : String)
      rss = XML.build(indent: "  ", encoding: "utf-8") do |xml|
        xml.element("rss", version: "2.0") do
          xml.element("channel") do
            xml.element("lastBuildDate") { xml.text Time.local.to_s("%F") }
            xml.element("link") { xml.text @config.base }
            xml.element("title") { xml.text @config.title }

            pages.map { |p| xml.element("item") do
              xml.element("description") { xml.text p.description }
              xml.element("link") { xml.text "#{@config.base}#{p.url}" }
              xml.element("pubDate") { xml.text p.date.to_s("%F") }
              xml.element("title") { xml.text p.title }
            end }
          end
        end
      end

      targetDir = @config.targetDir
      rssFilename = @config.rssFilename

      if !targetDir.nil? && !rssFilename.nil?
        File.write(Path[targetDir].join(lang, @config.rssFilename).to_s, rss)
      end
    end

    private def writeRedirection(lang : String)
      targetDir = @config.targetDir

      if !targetDir.nil?
        html = "<!DOCTYPE html><html><head><title>{{base}}/{{lang}}</title><link rel=\"canonical\" href=\"{{base}}/{{lang}}\"/><meta name=\"robots\" content=\"noindex\"/><meta charset=\"utf-8\"/><meta http-equiv=\"refresh\" content=\"0; url={{base}}/{{lang}}\" /></head></html>"
        File.write(Path[targetDir].join("index.html").to_s,
          html.gsub("{{base}}", @config.base).gsub("{{lang}}", lang))
      end
    end

    private def writePage(bo : BeulogueObject)
      toDir = File.dirname(bo.toPath.to_s)
      Dir.mkdir_p(toDir)

      model = BeuloguePage.new(bo, @config)

      Beulogue.logger.debug "Writing page #{bo.toPath}: #{model}"

      File.write(bo.toPath, HTML.unescape(@renderer.renderPage(model.to_hash)))

      model
    end
  end
end
