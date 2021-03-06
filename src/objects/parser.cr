require "crinja"
require "./content"

module Beulogue
  class BeulogueParser
    def self.transform_gemini(input : String)
      input
        .split("\n")
        .map { |e| e
          .gsub(/^=> ?(\S+) (.+)$/) { |s, m| "* [#{m[2]}](#{m[1]})" }
          .gsub(/^=> ?(.+)$/) { |s, m| "* <#{m[1]}>" } }
        .join("\n")
    end

    def self.parse(content : BeulogueContent, multilang : Array(Hash(String, String)))
      env = Crinja.new
      env.functions["dailymotion"] = fn_dailymotion
      env.functions["gist"] = fn_gist
      env.functions["vimeo"] = fn_vimeo
      env.functions["youtube"] = fn_youtube
      env.functions["ref"] = fn_ref(content, multilang)

      if content.is_gemini
        env.from_string(transform_gemini(content.content)).render
      else
        env.from_string(content.content).render
      end
      # begin
      # rescue
      #   puts "Failed to read #{content.fromPath}"
      #   ""
      # end
    end

    private def self.fn_dailymotion
      Crinja.function(arguments) do
        if arguments.varargs.size != 1
          puts "(function:dailymotion) Received #{arguments.varargs.size} arguments, expected: 1."
          puts "  usage: {{ dailymotion(\"video_id\") }}"
        else
          html = <<-HTML
    <iframe
      width="560" height="315"
      src="https://www.dailymotion.com/embed/video/#{arguments.varargs.shift.as_s}"
      frameborder="0"
      allow="accelerometer; encrypted-media; gyroscope; picture-in-picture"
      allowfullscreen ></iframe>
    HTML

          html
        end
      end
    end

    private def self.fn_gist
      Crinja.function(arguments) do
        if arguments.varargs.size != 2
          puts "(function:gist) Received #{arguments.varargs.size} arguments, expected: 2."
          puts "  usage: {{ gist(\"user_name\", \"gist_id\") }}"
        else
          html = <<-HTML
  <script src="https://gist.github.com/#{arguments.varargs.join("/")}.js"></script>
  HTML
          html
        end
      end
    end

    private def self.fn_ref(content : BeulogueContent, multilang : Array(Hash(String, String)))
      Crinja.function(arguments) do
        if arguments.varargs.size != 1
          puts "(function:ref) Received #{arguments.varargs.size} arguments, expected: 1."
          puts "  usage: {{ ref(\"markdown_filepath.md\") }} or {{ ref(\"gmi_filepath.gmi\") }}"
        else
          filepath = arguments.varargs.shift.as_s
          fromPath = content.fromPath
          url = content.toURL
          realFilepath = fromPath.parent.join(filepath).normalize
          lang = /^.*\.([\w\-]+)\.(md|gmi)$/.match(realFilepath.to_s).try &.[1] || ""

          if File.exists?(realFilepath)
            refContent = BeulogueContent.new(realFilepath, lang, content.lang, content.wd, false)
            model = BeuloguePage.new(refContent, Array(Hash(String, String)).new)

            link_url = if multilang.size == 0 || multilang[0]["language"] == model.language
                         model.url
                       else
                         "/#{model.language}#{model.url}"
                       end

            html = <<-HTML
            <a href="#{link_url}">#{model.title}</a>
            HTML

            html
          else
            puts("Failed to read referenced content: #{realFilepath}")
          end
        end
      end
    end

    private def self.fn_vimeo
      Crinja.function(arguments) do
        if arguments.varargs.size != 1
          puts "(vimeo) Received #{arguments.varargs.size} arguments, expected: 1."
          puts "  usage: {{ vimeo(\"video_id\") }}"
        else
          html = <<-HTML
    <iframe src="https://player.vimeo.com/video/#{arguments.varargs.shift.as_s}"
      width="640" height="360"
      frameborder="0"
      allow="fullscreen"
      allowfullscreen></iframe>
    HTML

          html
        end
      end
    end

    private def self.fn_youtube
      Crinja.function(arguments) do
        if arguments.varargs.size != 1
          puts "(youtube) Received: #{arguments.varargs.size} arguments, expected: 1."
          puts "  usage: {{ youtube(\"video_id\") }}"
        else
          html = <<-HTML
    <iframe
      width="560" height="315"
      src="https://www.youtube.com/embed/#{arguments.varargs.shift.as_s}"
      frameborder="0"
      allow="accelerometer; encrypted-media; gyroscope; picture-in-picture"
      allowfullscreen></iframe>
    HTML

          html
        end
      end
    end
  end
end
