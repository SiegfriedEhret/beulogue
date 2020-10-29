module Beulogue
  module Pipeline
    class List
      def self.write(renderer : Renderer, config : BeulogueConfig, pages : Array(BeuloguePage), lang : String, contentLang : String, dev_mode : Bool | Nil)
        targetDir = config.targetDir
        cwd = config.cwd
        defaultLanguage = config.languages[0]

        if !cwd.nil?
          if lang == defaultLanguage || lang == ""
            listContentPath = Path[cwd].join("content", "_index.md")
          else
            listContentPath = Path[cwd].join("content", "_index.#{lang}.md")
          end

          if !listContentPath.nil?
            if File.exists?(listContentPath)
              listContent = BeulogueContent.new(listContentPath, defaultLanguage, defaultLanguage, Path[cwd], dev_mode)
              model = BeuloguePage.new(listContent, Array(Hash(String, String)).new).to_hash
            end
          end
        end

        if !targetDir.nil?
          Dir.mkdir_p(targetDir)
          listModel = BeulogueList.new(pages, contentLang, config, listContent).to_hash

          if !model.nil?
            self.doWrite(renderer, targetDir, lang, listModel.merge(model))
          else
            self.doWrite(renderer, targetDir, lang, listModel)
          end
        end
      end

      def self.doWrite(renderer : Renderer, targetDir : String, lang : String, model : Hash)
        File.write(Path[targetDir].join(lang, "index.html").to_s,
          HTML.unescape(renderer.renderList(model)))
      end
    end
  end
end
