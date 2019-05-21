require "crustache"

class BeulogueContentFS < Crustache::HashFileSystem
  def load(name)
    if /\Adailymotion\s+([\w\-_]+)\z/ === name
      id = $1
      html = <<-HTML
      <iframe
        width="560" height="315"
        src="https://www.dailymotion.com/embed/video/#{id}"
        frameborder="0"
        allow="accelerometer; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen ><`/iframe>

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

      return Crustache.parse html
    end

    super
  end
end

module Beulogue
  class BeulogueContent
    def self.process(content : String)
      fs = BeulogueContentFS.new
      fs.register "test", Crustache.parse content

      engine = Crustache::Engine.new fs
      output = IO::Memory.new

      engine.render("test", nil)
    end
  end
end
