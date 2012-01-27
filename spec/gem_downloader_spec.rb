require "spec_helper"

describe "GemDownloader" do
  before(:each) do
    @gd = GemDownloader.new
    def @gd.latest_gems_file
      gzipped_gem_file = File.expand_path(File.dirname(__FILE__) + 
                                          "/latest_specs.4.8.gz")
      Gem.gunzip(File.read(gzipped_gem_file))
    end
  end

  it "#latest_gems should return an array of gems" do
    @gd.latest_gems.should be_an_instance_of Array
  end
end
