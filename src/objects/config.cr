require "yaml"

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
    include YAML::Serializable

    # From beulogue.yml
    property base : String
    property title : String
    property languages : Array(String)
    property rssFilename : String?
    property sortPagesBy : String?
    property sortPagesOrder : String?

    # Injected
    property cwd : String?
    property mode : Modes?
    property targetDir : String?
    property sortBy : PagesSortBy?
    property sortOrder : PagesSortOrder?
    property dev_mode : Bool?
  end
end
