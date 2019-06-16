require "./content"

module Beulogue
  class BeuloguePage
    getter content : String
    getter contentPath : String
    getter date : Time
    getter description : String
    getter language : String
    getter multilang : Array(Hash(String, String))
    getter orphan : Bool
    getter tags : Array(String)
    getter title : String
    getter url : String
    getter weight : Float64

    def initialize(content : BeulogueContent, multilang : Array(Hash(String, String)))
      @contentPath = content.contentPath
      @date = content.frontMatter.date
      @description = content.frontMatter.description
      @language = content.lang
      @multilang = multilang
      @orphan = content.frontMatter.orphan || false
      @tags = content.frontMatter.tags || Array(String).new
      @title = content.frontMatter.title
      @url = content.toURL
      @weight = content.frontMatter.weight || 1.0

      @content = BeulogueParser.parse(content) || ""
    end

    def to_hash
      model = {
        "content"       => @content,
        "contentPath"   => @contentPath,
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
