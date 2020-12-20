module Beulogue
  module Commands
    class Help
      def self.run
        Log.info { <<-HELP
          beulogue [<command>] [<options>]

          Commands:
              build     Build the site in the current working directory (default)
              init      Initialize a simple site
              help      Show help
              version   Print the current version of beulogue.

          Options:
              -dev, --development   Includes drafts, use localhost url
              -d, --debug           Show logs
              -h, --help            Show help

          More info: https://github.com/SiegfriedEhret/beulogue/
          HELP
 }

        exit 0
      end
    end
  end
end
