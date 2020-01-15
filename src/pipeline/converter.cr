module Beulogue
  module Pipeline
    class Converter
      def self.convert(fromPath : Path, lang : String, contentLang : String, cwd : Path, dev_mode : Bool | Nil)
        BeulogueContent.new(fromPath, lang, contentLang, cwd, dev_mode)
      end
    end
  end
end
