#!/usr/bin/env ruby
require 'pp'

lib_folder = File.expand_path(File.dirname(__FILE__) + "/../lib/")
puts "lib_folder: #{lib_folder}"
Dir["#{lib_folder}/*.rb"].each do |file|
  require file
end

gem_downloader = GemDownloader.new
gems = gem_downloader.latest_gems
# As of 1/21/12, the number of gems on RubyGems.org is greater than 30k
if gems.size < 30_000
    raise "The number of gems is less than expected: #{gems.size}"
else
    puts "The number of gems on RubyGems.org is #{gems.size}"
end
