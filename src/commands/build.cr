require "../config"
require "../pipeline/pipeline"

module Beulogue
  module Commands
    class Build
      def self.run(path : String, dev_mode : Bool)
        config = Conf.load(path, dev_mode)

        if config.nil?
          Beulogue.logger.fatal "Failed to read configuration, exiting."

          exit
        end

        Beulogue.logger.info "Building site: «#{config.title}»"

        processor = Beulogue::Pipeline::Pipeline.new(path, config)
        processor.run
      end
    end
  end
end
