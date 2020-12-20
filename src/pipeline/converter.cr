module Beulogue
  module Pipeline
    class Converter
      def self.convert(fromPath : Path, lang : String, contentLang : String, wd : Path, dev_mode : Bool | Nil)
        BeulogueContent.new(fromPath, lang, contentLang, wd, dev_mode)
      end
    end
  end
end
