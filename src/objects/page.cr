require "./content"

module Beulogue
  class BeuloguePage
    getter content : String
    getter date : Time
    getter description : String
    getter language : String
    getter multilang : Hash(String, String)
    getter tags : Array(String)
    getter title : String
    getter url : String

    def initialize(bo : BeulogueContent, multilang : Hash(String, String))
      @date = bo.frontMatter.date
      @description = bo.frontMatter.description
      @language = bo.lang
      @multilang = multilang
      @tags = bo.frontMatter.tags || Array(String).new
      @title = bo.frontMatter.title
      @url = bo.toURL

      @content = BeulogueParser.parse(bo.content) || ""
    end

    def to_hash
      model = {
        "content"       => @content,
        "date"          => @date,
        "dateFormatted" => @date.to_s("%F"),
        "description"   => @description,
        "language"      => @language,
        "multilang"     => @multilang,
        "tags"          => tags,
        "title"         => @title,
        "url"           => @url,
      }

      model
    end
  end
end
