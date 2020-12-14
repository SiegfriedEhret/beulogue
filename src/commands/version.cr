module Beulogue
  module Commands
    class Version
      def self.run
        Log.info { "beulogue v#{VERSION}" }

        exit
      end
    end
  end
end
