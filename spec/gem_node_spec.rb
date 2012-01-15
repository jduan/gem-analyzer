require "spec_helper"

describe GemNode do
    it "#<=> should compare number of consumers" do
        gem1 = GemNode.new("gem1")
        gem2 = GemNode.new("gem2")
        gem1.add_consumer("con1")
        gem1.add_consumer("con2")
        gem2.add_consumer("con1")

        (gem1 <=> gem2).should be > 0
    end
end
