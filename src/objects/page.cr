require "emoji"
require "markd"
require "./content"
require "./parser"

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
    getter is_markdown : Bool
    getter is_gemini : Bool
    getter is_draft : Bool

    def initialize(content : BeulogueContent, multilang : Array(Hash(String, String)))
      @contentPath = content.contentPath
      @date = content.frontMatter.date || Time.utc
      @description = content.frontMatter.description || ""
      @language = content.lang
      @multilang = multilang
      @orphan = content.frontMatter.orphan || false
      @tags = content.frontMatter.tags || Array(String).new
      @title = content.frontMatter.title
      @url = content.toURL
      @weight = content.frontMatter.weight || 1.0
      @is_markdown = content.is_markdown
      @is_gemini = content.is_gemini
      @is_draft = content.is_draft
      @content = Markd.to_html(Emoji.emojize(BeulogueParser.parse(content, multilang) || ""))
    end

    def to_hash
      model = {
        "content"       => @content,
        "contentPath"   => @contentPath,
        "date"          => @date,
        "dateFormatted" => @date.to_s("%F"),
        "description"   => @description,
        "is_draft"      => @is_draft,
        "language"      => @language,
        "multilang"     => @multilang.sort_by { |e| e["language"] },
        "tags"          => tags,
        "title"         => if @is_draft
          "#{@title} (draft)"
        else
          @title
        end,
        "type" => if @is_gemini
          "gemini"
        else
          "markdown"
        end,
        "url" => @url,
      }

      model
    end
  end
end
