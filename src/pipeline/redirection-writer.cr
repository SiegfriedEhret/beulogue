module Beulogue
  module Pipeline
    class Redirection
      def self.write(config : BeulogueConfig)
        targetDir = config.targetDir
        lang = config.languages[0]

        if !targetDir.nil?
          html = "<!DOCTYPE html><html><head><title>{{base}}/{{lang}}</title><link rel=\"canonical\" href=\"{{base}}/{{lang}}\"/><meta name=\"robots\" content=\"noindex\"/><meta charset=\"utf-8\"/><meta http-equiv=\"refresh\" content=\"0; url={{base}}/{{lang}}\" /></head></html>"
          File.write(Path[targetDir].join("index.html").to_s,
            html.gsub("{{base}}", config.base).gsub("{{lang}}", lang))
        end
      end
    end
  end
end
