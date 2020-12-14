require "../objects/list"

module Beulogue
  module Pipeline
    class Tag
      def self.write(renderer : Renderer, config : BeulogueConfig, pages : Array(BeuloguePage), tag : String, lang : String, contentLang : String)
        targetDir = config.targetDir

        if !targetDir.nil?
          model = BeulogueList.new(pages, contentLang, config, nil).to_hash
          to = Path[targetDir].join(lang, "tags", "#{tag}.html").to_s

          toDir = File.dirname(to.to_s)
          Dir.mkdir_p(toDir)

          content = HTML.unescape(renderer.renderTag(model))
          File.write(to, content)
        end
      end
    end
  end
end
