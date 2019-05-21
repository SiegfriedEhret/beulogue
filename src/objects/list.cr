module Beulogue
  class BeulogueList
    def initialize(@pages : Array(BeuloguePage), @lang : String)
    end

    def to_hash
      model = {
        "language" => @lang,
        "pages"    => @pages.sort_by { |p| p.date }.reverse.map { |p| p.to_hash },
      }

      model
    end
  end
end
