module Beulogue
  module Pipeline
    class Walker
      def self.run(path : Path, extra : String = "content")
        contentPath = path.join(extra)
        d = Dir.new(contentPath.to_s)

        files = [] of Path

        d.each_child do |x|
          if !x.starts_with? "_"
            currentPath = contentPath.join(x)
            if File.directory?(currentPath.to_s)
              files.concat(self.run(currentPath, ""))
            else
              files.push(currentPath)
            end
          end
        end

        files
      end
    end
  end
end
