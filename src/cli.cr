require "option_parser"
require "./commands/*"

module Beulogue
  DEFAULT_COMMAND = "build"

  def self.showHelp
    Beulogue.logger.info <<-HELP
      beulogue [<command>] [<options>]

      Commands:
          build     Build the site in the current working directory (default)
          help      Show help
          version   Print the current version of beulogue.

      Options:
          -dev, --development   Includes drafts, use localhost url
          -d, --debug           Show logs
          -h, --help            Show help

      More info: https://github.com/SiegfriedEhret/beulogue/
      HELP

    exit 0
  end

  def self.run
    OptionParser.parse do |parser|
      cwd = Dir.current
      dev_mode = false

      parser.banner = "Usage: beulogue [command] [flags]"
      parser.on("-d", "--debug", "Print debug logs.") { self.logger.level = Logger::Severity::DEBUG }
      parser.on("-dev", "--development", "Use dev mode (empty base url for development, includes drafts)") { dev_mode = true }
      parser.on("-h", "--help", "Show help") { self.showHelp }

      Beulogue.logger.debug "Working directory: #{cwd}"

      parser.invalid_option do |flag|
        STDERR.puts "ERROR: #{flag} is not a valid option."
        STDERR.puts parser
        exit(1)
      end

      parser.unknown_args do |args, options|
        case args[0]? || DEFAULT_COMMAND
        when "build"
          Commands::Build.run(cwd, dev_mode)
        when "help"
          self.showHelp
        when "version"
          Commands::Version.run
        end
      end
    end
  end
end

Beulogue.run
