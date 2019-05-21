require "crustache"

module Beulogue
  class Renderer
    getter fs : Crustache::ViewLoader
    getter list : Crustache::Template
    getter page : Crustache::Template
    getter baseModel : Hash(String, Hash(String, Array(String) | String) | Hash(String, String | Nil))

    def initialize(config : BeulogueConfig)
      fs = Crustache.loader Path[Dir.current].join("templates").to_s

      if fs
        @fs = fs
        @list = fs.load! "list.html"
        @page = fs.load! "page.html"
      else
        Beulogue.logger.fatal "Can't read templates"
        exit 1
      end

      @baseModel = {
        "beulogue" => {
          "cwd"     => config.cwd,
          "version" => VERSION,
        },
        "site" => {
          "title"     => config.title,
          "languages" => config.languages,
        },
      }
    end

    def renderList(content : Hash)
      model = @baseModel.merge(content)

      Beulogue.logger.debug "Writing list for lang #{model["language"]}: #{model}"

      html = Crustache.render(@list, model, @fs)
    end

    def renderPage(content : Hash)
      model = @baseModel.merge(content)

      Beulogue.logger.debug "Writing page: #{model}"

      html = Crustache.render(@page, model, @fs)
    end
  end
end
