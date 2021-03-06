require "yaml"
require "./objects/config"

module Beulogue
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

  module Conf
    def self.load(wd : String, dev_mode : Bool)
      wdPath = Path[wd]
      configPath = wdPath.join("beulogue.yml")

      Log.debug { "Reading config at: #{configPath.to_s}" }

      config = BeulogueConfig.from_yaml(File.read(configPath))
      config.wd = wd

      if dev_mode
        config.mode = Modes::Dev
      end

      config.targetDir = wdPath.join("public").to_s

      if config.sortPagesBy && config.sortPagesBy == "weight"
        config.sortBy = PagesSortBy::Weight
      else
        config.sortBy = PagesSortBy::Date
      end

      if config.sortPagesOrder && config.sortPagesOrder == "asc"
        config.sortOrder = PagesSortOrder::Asc
      else
        config.sortOrder = PagesSortOrder::Desc
      end

      if !config.rssFilename
        config.rssFilename = "feed.xml"
      end

      Log.debug { "Config: #{config.inspect}" }

      config
    end
  end
end
