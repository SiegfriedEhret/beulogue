require "yaml"

module Beulogue
  struct BeulogueFrontMatter
    include YAML::Serializable

    property title : String

    property date : Time?
    property description : String?
    property tags : Array(String)?
    property orphan : Bool?
    property weight : Float64?
  end
end
