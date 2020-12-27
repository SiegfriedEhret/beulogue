require "./spec_helper"
require "../src/objects/parser"

describe Beulogue::BeulogueParser do
  it "Convert links" do
    from = "=> https://invisible-island.net/lynx/ Lynx official website"
    to = "* [Lynx official website](https://invisible-island.net/lynx/)"
    Beulogue::BeulogueParser.transform_gemini(from).should eq(to)
  end

  it "works for a wall of text", focus: true do
    from = File.read("#{__DIR__}/fixtures/text.gmi")
    to = File.read("#{__DIR__}/fixtures/text.md")
    Beulogue::BeulogueParser.transform_gemini(from).should eq(to)
  end
end
