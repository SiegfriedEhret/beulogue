module Beulogue
  module Pipeline
    class List
      def self.write(renderer : Renderer, config : BeulogueConfig, pages : Array(BeuloguePage), lang : String)
        targetDir = config.targetDir

        if !targetDir.nil?
          File.write(Path[targetDir].join(lang, "index.html").to_s,
            HTML.unescape(renderer.renderList(BeulogueList.new(pages, lang, config).to_hash)))
        end
      end
    end
  end
end
