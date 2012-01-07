project_root_folder = File.expand_path(File.dirname(__FILE__) + "/../")
Dir["#{project_root_folder}/*.rb"].each do |file|
  require file
end

lib_folder = File.expand_path(File.dirname(__FILE__) + "/../lib/")
Dir["#{lib_folder}/*.rb"].each do |file|
  require file
end
