#!/usr/bin/env ruby
require 'pp'

lib_folder = File.expand_path(File.dirname(__FILE__) + "/lib/")
puts "lib_folder: #{lib_folder}"
Dir["#{lib_folder}/*.rb"].each do |file|
  require file
end

gem_downloader = GemDownloader.new
gem_analyzer = GemAnalyzer.new(gem_downloader)
gem_analyzer.analyze
