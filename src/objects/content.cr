module Beulogue
  class BeulogueContent
    getter fromPath : Path
    getter toPath : Path
    getter toURL : String
    getter content : String
    getter lang : String
    getter frontMatter : BeulogueFrontMatter

    def initialize(@fromPath : Path, lang : String, cwd : Path)
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
      @content = Markdown.to_html(content)
      @lang = lang

      tempToPath = fromPath.to_s.sub("/content/", "/public/#{lang}/")

      if (tempToPath.ends_with?(".#{lang}.md"))
        @toPath = Path[tempToPath.sub(".#{lang}.md", ".html")]
      else
        @toPath = Path[tempToPath.sub(".md", ".html")]
      end

      @toURL = @toPath.to_s.gsub("//", "/").sub(cwd.join("public").to_s, "")
    end
  end
end
