require "log"
require "option_parser"
require "./commands/*"

module Beulogue
  DEFAULT_COMMAND = "build"

  def self.run
    OptionParser.parse do |parser|
      cwd = Dir.current
      dev_mode = false

      parser.banner = "Usage: beulogue [command] [flags]"
      parser.on("-d", "--debug", "Print debug logs.") { Log.setup :debug }
      parser.on("-dev", "--development", "Use dev mode (empty base url for development, includes drafts)") { dev_mode = true }
      parser.on("-h", "--help", "Show help") { Commands::Help.run }

      Log.debug { "Working directory: #{cwd}" }

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
          Commands::Help.run
        when "version"
          Commands::Version.run
        end
      end
    end
  end
end

Beulogue.run
