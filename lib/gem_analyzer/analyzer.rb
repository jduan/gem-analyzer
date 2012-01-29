require "pp"

# This class analyzes all the gems from RubyGems.org and find the
# mostly consumed gems that other gems depend on.
module GemAnalyzer
  class Analyzer
    def initialize(gem_downloader)
      @gem_downloader = gem_downloader
    end

    def analyze(num_of_gems = nil)
      gem_names = download_latest_gem_names
      # analyze all the gems if nil is passed in
      if num_of_gems.nil?
        gem_names_analyzed = gem_names
      else
        gem_names_analyzed = gem_names.sample(num_of_gems)
      end

      all_gems = {}
      gem_names_analyzed.each_with_index do |gem_name, index|
        puts "#{index}: analyzing gem #{gem_name}..."
        find_dependencies_of(gem_name, all_gems)
      end
      all_gems.values.sort.each do |gem_node|
        puts "gem #{gem_node.name}, version: #{gem_node.version}, " +
        "consumers: #{gem_node.consumers.size}"
      end

      puts "total number of consumed gems: #{all_gems.size}"
    end

    # Download all the gems and return the gem names.
    def download_latest_gem_names
      latest_gems = @gem_downloader.latest_gems
      puts "total number of gems: #{latest_gems.size}"

      latest_gems.inject([]) do |names, gem|
        name = gem[0]
        version = gem[1].version
        names << name
      end
    end

    # return the names of the dependency gems for a given gem
    def find_dependencies_of(gem_name, all_gems)

      dependencies = []
      loop do
        begin
          dependencies = Gems.dependencies(gem_name)
          break
        rescue => e
          # RubyGems.org isn't stable all the time. It can become 
          # unreachable sometimes. We retry if that happens.
          puts "caught exception when calling RubyGems.org: #{e}, retry..."
        end
      end

      dependencies.each do |h|
        version = h[:number]
        consumer = NameAndVersion.new(gem_name, version)

        h[:dependencies].each do |dep|
          dep_name = dep[0]
          dep_version = dep[1]
          dep_gem_key = NameAndVersion.new(dep_name, dep_version)
          dep_gem = all_gems[dep_gem_key] || GemNode.new(dep_name, dep_version)
          dep_gem.add_consumer(consumer)

          all_gems[dep_gem_key] = dep_gem
        end
      end
    end
  end

  NameAndVersion = Struct.new(:name, :version)
end
