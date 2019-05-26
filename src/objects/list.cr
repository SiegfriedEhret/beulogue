module Beulogue
  class BeulogueList
    def initialize(@pages : Array(BeuloguePage), @lang : String, @config : BeulogueConfig)
    end

    def to_hash
      if @config.sortBy == PagesSortBy::Weight
        sorted = @pages.sort_by { |p| p.weight }
      else
        sorted = @pages.sort_by { |p| p.date }
      end

      if @config.sortOrder == PagesSortOrder::Desc
        sorted = sorted.reverse
      end

      model = {
        "language" => @lang,
        "pages"    => sorted.map { |p| p.to_hash.reject("content") },
      }

      model
    end
  end
end
