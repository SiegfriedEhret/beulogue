require "crustache"
require "./content"

module Beulogue
  class BeulogueParserFS < Crustache::HashFileSystem
    def setContext(content : BeulogueContent)
      @content = content
    end

    def load(name)
      # Internal contents

      if /\Aref\s+(.+)\z/ === name
        filepath = $1

        content = @content
        if content.nil?
          return
        else
          fromPath = content.fromPath
          url = content.toURL
          realFilepath = fromPath.parent.join(filepath).normalize
          lang = /^.*\.([\w\-]+)\.md$/.match(realFilepath.to_s).try &.[1] || ""

          puts "><> #{realFilepath} #{lang}"
          if File.exists?(realFilepath)
            refContent = BeulogueContent.new(realFilepath, lang, content.cwd)
            model = BeuloguePage.new(refContent, Array(Hash(String, String)).new)
            puts "<>< #{model.url} #{model.title}"

            html = <<-HTML
            <a href="#{model.url}">#{model.title}</a>
            HTML
          else
            Beulogue.logger.warn("Failed to read referenced content: #{realFilepath}")
          end
        end
      end

      # External contents

      if /\Adailymotion\s+([\w\-_]+)\z/ === name
        id = $1

        html = <<-HTML
      <iframe
        width="560" height="315"
        src="https://www.dailymotion.com/embed/video/#{id}"
        frameborder="0"
        allow="accelerometer; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen ></iframe>
      HTML
      end

      if /\Agist\s+([\w\-_]+)\s+([\w\-_]+)\z/ === name
        user = $1
        id = $2

        html = <<-HTML
      <script src="https://gist.github.com/#{user}/#{id}.js"></script>
      HTML
      end

      if /\Avimeo\s+([\w\-_]+)\z/ === name
        id = $1

        html = <<-HTML
      <iframe src="https://player.vimeo.com/video/#{id}"
        width="640" height="360"
        frameborder="0"
        allow="fullscreen"
        allowfullscreen></iframe>
      HTML
      end

      if /\Ayoutube\s+([\w\-_]+)\z/ === name
        id = $1

        html = <<-HTML
      <iframe
        width="560" height="315"
        src="https://www.youtube.com/embed/#{id}"
        frameborder="0"
        allow="accelerometer; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen></iframe>
      HTML
      end

      if html
        return Crustache.parse html
      end

      super
    end
  end

  class BeulogueParser
    def self.parse(bc : BeulogueContent)
      fs = BeulogueParserFS.new
      fs.setContext bc
      fs.register "beulogue", Crustache.parse bc.content

      engine = Crustache::Engine.new fs
      output = IO::Memory.new

      engine.render("beulogue", nil)
    end
  end
end
