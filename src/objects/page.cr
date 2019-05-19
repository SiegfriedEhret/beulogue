require "./content"

module Beulogue
  class BeuloguePage
    getter beulogueCwd : String?
    getter content : String
    getter date : Time
    getter description : String
    getter language : String
    getter tags : Array(String)
    getter title : String
    getter siteTitle : String
    getter siteLanguages : Array(String)
    getter url : String

    def initialize(bo : BeulogueObject, config : BeulogueConfig)
      @beulogueCwd = config.cwd
      @date = bo.frontMatter.date
      @description = bo.frontMatter.description
      @language = bo.lang
      @siteTitle = config.title
      @siteLanguages = config.languages
      @tags = bo.frontMatter.tags || Array(String).new
      @title = bo.frontMatter.title
      @url = bo.toURL

      @content = BeulogueContent.process(bo.content) || ""
    end

    def to_hash
      model = {
        "beulogue" => {
          "cwd"     => @beulogueCwd,
          "version" => VERSION,
        },
        "content"       => @content,
        "date"          => @date,
        "dateFormatted" => @date.to_s("%F"),
        "description"   => @description,
        "language"      => @language,
        "tags"          => tags,
        "site"          => {
          "title"     => @siteTitle,
          "languages" => @siteLanguages,
        },
        "title" => @title,
        "url"   => @url,
      }

      model
    end
  end
end
