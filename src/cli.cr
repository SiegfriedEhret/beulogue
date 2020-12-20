require "log"
require "option_parser"
require "./commands/*"

module Beulogue
  DEFAULT_COMMAND = "build"

  def self.run
    OptionParser.parse do |parser|
      wd = Dir.current
      dev_mode = false

      parser.banner = "Usage: beulogue [command] [flags]"
      parser.on("-d", "--debug", "Print debug logs.") { Log.setup :debug }
      parser.on("-dev", "--development", "Use dev mode (empty base url for development, includes drafts)") { dev_mode = true }
      parser.on("-w NAME", "--working-directory=NAME", "Set the working directory (default: current working directory)") { |name| wd = name }
      parser.on("-h", "--help", "Show help") { Commands::Help.run }

      Log.debug { "Working directory: #{wd}" }

      parser.invalid_option do |flag|
        STDERR.puts "ERROR: #{flag} is not a valid option."
        STDERR.puts parser
        exit(1)
      end

      parser.unknown_args do |args, options|
        case args[0]? || DEFAULT_COMMAND
        when "build"
          Commands::Build.run(wd, dev_mode)
        when "help"
          Commands::Help.run
        when "init"
          Commands::Init.new(args[1..-1])
        when "version"
          Commands::Version.run
        end
      end
    end
  end
end

Beulogue.run
