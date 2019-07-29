module Beulogue
  module Pipeline
    class Converter
      def self.convert(fromPath : Path, lang : String, contentLang : String, cwd : Path)
        BeulogueContent.new(fromPath, lang, contentLang, cwd)
      end
    end
  end
end
