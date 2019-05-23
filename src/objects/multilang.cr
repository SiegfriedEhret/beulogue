module Beulogue
  class BeulogueMultilang
    getter data : Hash(String, Hash(String, String))

    def initialize
      @data = Hash(String, Hash(String, String)).new
    end

    def add(url : String, lang : String, targetUrl : String)
      if !@data[url]?
        @data[url] = Hash(String, String).new
      end

      @data[url][lang] = targetUrl
    end

    def get(url : String)
      result = Array(String)
      result = @data[url].map do |language, url|
        model = {
          "language" => language,
          "url"      => url,
        }

        model
      end

      result
    end
  end
end
