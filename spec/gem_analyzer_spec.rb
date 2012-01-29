require "spec_helper"

describe GemAnalyzer::Analyzer do
  before(:each) do
    @gem_downloader = double
    #email.stub(:subject).and_return(subject)
    @analyzer = GemAnalyzer::Analyzer.new(@gem_downloader)
  end
end
