#!/usr/bin/env ruby

lib_folder = File.expand_path(File.dirname(__FILE__) + "/lib/")
puts "lib_folder: #{lib_folder}"
Dir["#{lib_folder}/*.rb"].each do |file|
  require file
end

downloader = GemDownloader.new
latest_gems = downloader.latest_gems
puts "number of gems: #{latest_gems.size}"
h = {}
latest_gems.each do |gem|
    version = gem[1]
    size = version.version.split(".").size
    h[size] ||= 0
    h[size] += 1
end

puts h
