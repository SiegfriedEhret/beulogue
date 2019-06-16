require "yaml"
require "./objects/config"

module Beulogue
  DEFAULT_COMMAND = "build"
  VERSION         = {{ `cat #{__DIR__}/../VERSION`.stringify.chomp }}

  module Conf
    def self.load(cwd : String)
      cwdPath = Path[cwd]
      configPath = cwdPath.join("beulogue.yml")

      Beulogue.logger.debug "Reading config at: #{configPath.to_s}"

      config = BeulogueConfig.from_yaml(File.read(configPath))
      config.cwd = cwd
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
