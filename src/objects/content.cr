require "emoji"

module Beulogue
  class BeulogueContent
    getter base : String
    getter content : String
    getter contentPath : String
    getter cwd : Path
    getter fromPath : Path
    getter toPath : Path
    getter toURL : String
    getter lang : String
    getter frontMatter : BeulogueFrontMatter

    def initialize(@fromPath : Path, pathLang : String, contentLang : String, @cwd : Path)
      frontMatterDelimiter = "---"
      frontMatterDelimiterCount = 0
      frontMatter = ""
      content = ""

      File.read_lines(fromPath).each do |line|
        if frontMatterDelimiterCount < 2
          if line == frontMatterDelimiter
            frontMatterDelimiterCount += 1
          else
            frontMatter += line + "\n"
          end
        else
          content += line + "\n"
        end
      end

      @frontMatter = BeulogueFrontMatter.from_yaml(frontMatter)
      @content = Markdown.to_html(Emoji.emojize(content))
      @lang = contentLang

      suffix = ".md"
      if fromPath.to_s.ends_with?(".#{pathLang}#{suffix}")
        suffix = ".#{pathLang}#{suffix}"
      end

      @contentPath = fromPath.to_s.sub(@cwd.join("content").to_s, "")

      @base = fromPath.to_s.sub(suffix, "")

      tempToPath = fromPath.to_s.sub("/content/", "/public/#{pathLang}/").gsub("//", "/")

      @toPath = Path[tempToPath.sub(suffix, ".html")]

      @toURL = @toPath.to_s.sub(@cwd.join("public").to_s, "")
    end
  end
end
