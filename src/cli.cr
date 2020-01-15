require "option_parser"
require "./commands/*"

module Beulogue
  def self.run
    OptionParser.parse do |opts|
      cwd = Dir.current
      dev_mode = false

      opts.on("-d", "--debug", "Print debug logs.") { self.logger.level = Logger::Severity::DEBUG }
      opts.on("-dev", "--development", "Use dev mode (empty base url for development, includes drafts)") { dev_mode = true }

      Beulogue.logger.debug "Working directory: #{cwd}"

      opts.unknown_args do |args, options|
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

begin
  Beulogue.run
rescue ex : OptionParser::InvalidOption
  Beulogue.logger.fatal ex.message
  exit 1
end
