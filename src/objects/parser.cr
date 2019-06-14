require "crustache"

class BeulogueParserFS < Crustache::HashFileSystem
  def load(name)
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

module Beulogue
  class BeulogueParser
    def self.parse(content : String)
      fs = BeulogueParserFS.new
      fs.register "beulogue", Crustache.parse content

      engine = Crustache::Engine.new fs
      output = IO::Memory.new

      engine.render("beulogue", nil)
    end
  end
end
