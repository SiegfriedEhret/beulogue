require "yaml"

module Beulogue
  class BeulogueFrontMatter
    include YAML::Serializable

    property date : Time
    property description : String
    property title : String
    property tags : Array(String)?
    property orphan : Bool?
    property weight : Float64?
  end
end
