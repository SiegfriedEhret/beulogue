require "yaml"
require "./objects/config"

module Beulogue
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

  module Conf
    def self.load(cwd : String, dev_mode : Bool)
      cwdPath = Path[cwd]
      configPath = cwdPath.join("beulogue.yml")

      Beulogue.logger.debug "Reading config at: #{configPath.to_s}"

      config = BeulogueConfig.from_yaml(File.read(configPath))
      config.cwd = cwd

      if dev_mode
        config.mode = Modes::Dev
      end

      config.targetDir = cwdPath.join("public").to_s

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

      Beulogue.logger.debug "Config: #{config.inspect}"

      config
    end
  end
end
