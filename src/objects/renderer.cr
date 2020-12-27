require "crinja"

module Beulogue
  class Renderer
    getter list : Crinja::Template
    getter page : Crinja::Template
    getter tag : Crinja::Template
    getter baseModel : Hash(String, Hash(String, Array(String) | String) | Hash(String, String | Nil))

    def initialize(config : BeulogueConfig)
      env = Crinja.new
      env.loader = Crinja::Loader::FileSystemLoader.new(Path[config.wd || Dir.current].join("templates").to_s)

      @list = env.get_template("list.html")
      @page = env.get_template("page.html")
      @tag = @list

      begin
        @tag = env.get_template "tag.html"
      rescue ex
        Log.warn { "Failed to load tag page template." }
        Log.debug { ex.message }
      end

      @baseModel = {
        "beulogue" => {
          "wd"      => config.wd,
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

      Log.debug { "Writing list for lang #{model["language"]}" }

      html = @list.render model
    end

    def renderPage(content : Hash)
      model = @baseModel.merge(content)

      Log.debug { "Writing page: #{model["multilang"]}" }

      html = @page.render model
    end

    def renderTag(content : Hash)
      model = @baseModel.merge(content)

      Log.debug { "Writing tag page: #{model}" }

      html = @tag.render model
    end
  end
end
