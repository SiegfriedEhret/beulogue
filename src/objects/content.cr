require "./front-matter"

module Beulogue
  SUFFIX_MARKDOWN = ".md"
  SUFFIX_GMI      = ".gmi"

  class BeulogueContent
    getter base : String
    getter content : String
    getter contentPath : String
    getter wd : Path
    getter fromPath : Path
    getter toPath : Path
    getter toURL : String
    getter lang : String
    getter frontMatter : BeulogueFrontMatter
    getter is_markdown : Bool
    getter is_gemini : Bool

    def initialize(@fromPath : Path, pathLang : String, contentLang : String, @wd : Path, dev_mode : Bool | Nil)
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
      @content = content
      @lang = contentLang

      suffix = SUFFIX_MARKDOWN
      @is_markdown = true
      @is_gemini = false

      if fromPath.to_s.ends_with? SUFFIX_GMI
        suffix = SUFFIX_GMI
        @is_markdown = false
        @is_gemini = true
      end

      if fromPath.to_s.ends_with?(".#{pathLang}#{suffix}")
        suffix = ".#{pathLang}#{suffix}"
      end

      folderName = "content"
      if dev_mode == true && fromPath.to_s.includes? "/drafts"
        folderName = "drafts"
      end

      @contentPath = fromPath.to_s.sub(@wd.join(folderName).to_s, "")
      @base = fromPath.to_s.sub(suffix, "")

      tempToPath = fromPath.to_s.sub("/#{folderName}/", "/public/#{pathLang}/").gsub("//", "/")
      @toPath = Path[tempToPath.sub(suffix, ".html")]

      path_to_remove = @wd.join("public").to_s.sub("./", "")
      @toURL = @toPath.to_s.sub(path_to_remove, "")
    end
  end
end
