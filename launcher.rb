#!/usr/bin/env ruby
require 'pp'

lib_folder = File.expand_path(File.dirname(__FILE__) + "/lib/")
puts "lib_folder: #{lib_folder}"
Dir["#{lib_folder}/*.rb"].each do |file|
  require file
end

# This makes stdout flush after each 'puts' so I can see the 
# results in the output file right away. Analyzing over 30k
# gems takes a lot of time and I'd like to see where the progress
# is along the way.
STDOUT.sync = true

gem_downloader = GemDownloader.new
gem_analyzer = GemAnalyzer.new(gem_downloader)
gem_analyzer.analyze_new(ARGV[0].nil? ? nil : ARGV[0].to_i)
