require "spec_helper"

describe "GemAnalyzer" do
  it "should foo" do
    baz = GemAnalyzer.new
    bar = baz.foo
    bar.should == "BAR"
  end
end
