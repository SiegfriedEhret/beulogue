module Beulogue
  enum Modes
    Dev
  end

  enum PagesSortBy
    Date
    Weight
  end

  enum PagesSortOrder
    Asc
    Desc
  end

  class BeulogueConfig
    YAML.mapping(
      # From beulogue.yml
      base: String,
      title: String,
      languages: Array(String),
      rssFilename: String?,
      sortPagesBy: String?,
      sortPagesOrder: String?,

      # Injected
      cwd: String?,
      mode: Modes?,
      targetDir: String?,
      sortBy: PagesSortBy?,
      sortOrder: PagesSortOrder?,
      dev_mode: Bool?,
    )
  end
end
