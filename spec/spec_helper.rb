lib_folder = File.expand_path(File.dirname(__FILE__) + "/../lib/")
Dir["#{lib_folder}/*.rb"].each do |file|
  require file
end
