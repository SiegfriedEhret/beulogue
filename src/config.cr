require "yaml"
require "./objects/config"

module Beulogue
  DEFAULT_COMMAND = "build"
  VERSION         = "1.3.1"

  module Conf
    def self.load(cwd : String)
      cwdPath = Path[cwd]
      configPath = cwdPath.join("beulogue.yml")

      Beulogue.logger.debug "Reading config at: #{configPath.to_s}"

      config = BeulogueConfig.from_yaml(File.read(configPath))
      config.cwd = cwd
      config.targetDir = cwdPath.join("public").to_s

      if !config.rssFilename
        config.rssFilename = "feed.xml"
      end

      Beulogue.logger.debug "Config: #{config.inspect}"

      config
    end
  end
end
