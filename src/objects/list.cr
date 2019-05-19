module Beulogue
  class BeulogueList
    def self.to_hash(config : BeulogueConfig, pages : Array(BeuloguePage), lang : String)
      model = {
        "beulogue" => {
          "cwd"     => config.cwd,
          "version" => VERSION,
        },
        "language" => lang,
        "pages"    => pages.sort_by { |p| p.date }.reverse.map { |p| p.to_hash },
        "site"     => {
          "title"     => config.title,
          "languages" => config.languages,
        },
      }

      model
    end
  end
end
