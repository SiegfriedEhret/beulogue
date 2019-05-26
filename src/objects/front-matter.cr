module Beulogue
  class BeulogueFrontMatter
    YAML.mapping(
      date: Time,
      description: String,
      title: String,
      tags: Array(String)?,
      orphan: Bool?,
      weight: Float64?,
    )
  end
end
