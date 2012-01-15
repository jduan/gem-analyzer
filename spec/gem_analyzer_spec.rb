require "spec_helper"

describe GemAnalyzer do
    before(:each) do
        @gem_downloader = double
        #email.stub(:subject).and_return(subject)
        @analyzer = GemAnalyzer.new(@gem_downloader)
    end

    context "#is_semver?" do
        it "should return true for 10.1.3" do
            @analyzer.is_semver?("10.1.3").should be_true
        end

        it "should return true for 1.2.3" do
            @analyzer.is_semver?("1.2.3").should be_true
        end

        it "should return false for 1.2" do
            @analyzer.is_semver?("1.2").should be_false
        end
    end
end
