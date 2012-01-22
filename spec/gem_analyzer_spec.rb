require "spec_helper"

describe GemAnalyzer do
    before(:each) do
        @gem_downloader = double
        #email.stub(:subject).and_return(subject)
        @analyzer = GemAnalyzer.new(@gem_downloader)
    end
end
