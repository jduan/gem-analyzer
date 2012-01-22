require "pp"

# This class analyzes all the gems from RubyGems.org and find the
# mostly consumed gems that other gems depend on.
class GemAnalyzer
    def initialize(gem_downloader)
        @gem_downloader = gem_downloader
    end

    def analyze_new(num_of_gems = nil)
        gem_names = download_latest_gem_names
        # analyze all the gems if nil is passed in
        num_of_gems = gem_names.size if num_of_gems.nil?

        all_gems = {}
        gem_names[0, num_of_gems].each do |gem_name|
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

        gem_names = []
        latest_gems.each do |gem|
            name = gem[0]
            version = gem[1].version
            gem_names << name
        end

        gem_names
    end

    # return the names of the dependency gems for a given gem
    def find_dependencies_of(gem_name, all_gems)
        puts "Analyzing #{gem_name}..."

        dependencies = []
        Gems.dependencies(gem_name).each do |h|
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
