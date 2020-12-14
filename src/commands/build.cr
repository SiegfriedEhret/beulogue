require "../config"
require "../pipeline/pipeline"

module Beulogue
  module Commands
    class Build
      def self.run(path : String, dev_mode : Bool)
        config = Conf.load(path, dev_mode)

        if config.nil?
          Log.fatal { "Failed to read configuration, exiting." }

          exit
        end

        Log.info { "Building site: «#{config.title}»" }
        config.dev_mode = dev_mode

        processor = Beulogue::Pipeline::Pipeline.new(path, config)
        processor.run
      end
    end
  end
end
