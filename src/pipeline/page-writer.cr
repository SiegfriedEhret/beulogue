module Beulogue
  module Pipeline
    class Page
      def self.write(renderer : Renderer, content : BeulogueContent, multiLang : BeulogueMultilang)
        toDir = File.dirname(content.toPath.to_s)
        model = BeuloguePage.new(content, multiLang.get(content.base))

        Dir.mkdir_p(toDir)
        File.write(content.toPath, HTML.unescape(renderer.renderPage(model.to_hash)))

        model
      end
    end
  end
end
