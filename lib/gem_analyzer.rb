require "pp"

# This class analyzes all the gems from RubyGems.org and find the
# mostly consumed gems that other gems depend on.
class GemAnalyzer
    # Number of gems to analyze. This is so I can test the app.
    # TODO: remove this limit so all gems are analyzed
    LIMIT = 10
    # Number of mostly used gems to print
    TOP_GEMS = 10

    def initialize(gem_downloader)
        @gem_downloader = gem_downloader
    end

    def analyze_new(num_of_gems = nil)
        gem_names = download_latest_gem_names
        # analyze all the gems if nil is passed in
        num_of_gems = gem_names.size if num_of_gems.nil?

        all_gems = {}
        gem_names[0, num_of_gems].each do |gem_name|
            OneGemAnalyzer.find_dependencies_of(gem_name, all_gems)
        end
        all_gems.values.sort.each do |gem_node|
            puts "gem #{gem_node.name}, version: #{gem_node.version}, " +
                "consumers: #{gem_node.consumers.size}"
        end

        puts "total number of consumed gems: #{all_gems.size}"
    end

    def analyze
        gem_names = download_latest_gem_names
        # gem_name => gem_node
        name_to_node = build_hash_of_all_gems(gem_names)
        # gem_name => array of dependencies
        name_to_dependencies = find_dependencies_of_all_gems(gem_names)

        name_to_dependencies.each do |gem_name, dependencies|
            dependencies.each do |dep_name|
                dep_node = name_to_node[dep_name]
                node = name_to_node[gem_name]
                node.add_dependency(dep_node)
                dep_node.add_consumer(node)
            end
        end

        print_result(name_to_node)
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

    # build a hash of gem_name => gem_node
    def build_hash_of_all_gems(gem_names)
        hash = {} # gem_name => gem_node

        # build a hash of gem_name => gem_node
        gem_names.each do |gem_name|
            node = GemNode.new(gem_name)
            hash[gem_name] = node
        end

        hash
    end

    # Return a hash of gem_name => array of dependencies
    def find_dependencies_of_all_gems(gem_names)
        name_to_dependencies = {}
        # go through all the gems and update dependencies and
        # consumers for each gem
        limit = LIMIT
        gem_names.each do |gem_name|
            dependencies = find_dependencies_of(gem_name)
            name_to_dependencies[gem_name] = dependencies
            limit -= 1
            break if limit == 0
        end

        name_to_dependencies
    end

    def print_result(name_to_node)
        sorted_array = name_to_node.sort_by do |gem_name, gem_node|
            gem_node
        end

        counter = TOP_GEMS
        sorted_array.reverse.each do |gem_name, gem_node|
            puts gem_node
            counter -= 1
            break if counter == 0
        end
    end

    # return the names of the dependency gems for a given gem
    def find_dependencies_of(gem_name)
        dependencies = []
        Gems.dependencies(gem_name).each do |h|
            number = h[:number]
            h[:dependencies].each do |dep|
                dep_name = dep[0]
                # dep_version = normalize_version(dep[1])
                # nodes << GemNode.new(dep_name, dep_version)
                dependencies << dep_name unless dependencies.include? dep_name
            end
        end

        dependencies
    end

    # TODO: the functions below aren't being used yet, they will
    # become useful when we take gem version into consideration.
    def version_prefix(version)
        md = /^(.+?)\d/.match(version)
        if md.nil?
            ""
        else
            md[1].strip
        end
    end

    def normalize_version(version)
        case version
        when /^~>/
            version[2..-1].strip
        when /^=/
            version[1..-1].strip
        when /^>=/
            version[2..-1].strip
        else
            raise "unknown version: #{version}"
        end
    end

    # Return true if the version follows 'semantic versioning'
    def is_semver?(version)
        version =~ /^\d+\.\d+\.\d+$/ ? true : false
    end

end
