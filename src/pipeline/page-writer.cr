module Beulogue
  module Pipeline
    class Page
      def self.write(renderer : Renderer, bo : BeulogueContent)
        toDir = File.dirname(bo.toPath.to_s)
        Dir.mkdir_p(toDir)
        model = BeuloguePage.new(bo)
        File.write(bo.toPath, HTML.unescape(renderer.renderPage(model.to_hash)))

        model
      end
    end
  end
end
