module Beulogue
  module Pipeline
    class RSS
      def self.write(config : BeulogueConfig, pages : Array(BeuloguePage), lang : String)
        rss = XML.build(indent: "  ", encoding: "utf-8") do |xml|
          xml.element("rss", version: "2.0") do
            xml.element("channel") do
              xml.element("lastBuildDate") { xml.text Time.local.to_s("%F") }
              xml.element("link") { xml.text config.base }
              xml.element("title") { xml.text config.title }

              pages.map { |p| xml.element("item") do
                xml.element("description") { xml.text p.description }
                xml.element("link") { xml.text "#{config.base}#{p.url}" }
                xml.element("pubDate") { xml.text p.date.to_s("%F") }
                xml.element("title") { xml.text p.title }
              end }
            end
          end
        end

        targetDir = config.targetDir
        rssFilename = config.rssFilename

        if !targetDir.nil? && !rssFilename.nil?
          File.write(Path[targetDir].join(lang, config.rssFilename).to_s, rss)
        end
      end
    end
  end
end
