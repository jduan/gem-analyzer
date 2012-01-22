#!/usr/bin/env ruby
require 'pp'
require 'set'

lib_folder = File.expand_path(File.dirname(__FILE__) + "/../lib/")
puts "lib_folder: #{lib_folder}"
Dir["#{lib_folder}/*.rb"].each do |file|
  require file
end

all_gems = {}
OneGemAnalyzer.find_dependencies_of("rails", all_gems)
all_gems.values.sort.each do |gem_node|
    puts "gem #{gem_node.name}, version: #{gem_node.version}, consumers: #{gem_node.consumers.size}"
end
