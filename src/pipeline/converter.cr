module Beulogue
  module Pipeline
    class Converter
      def self.convert(fromPath : Path, lang : String, cwd : Path)
        BeulogueContent.new(fromPath, lang, cwd)
      end
    end
  end
end
