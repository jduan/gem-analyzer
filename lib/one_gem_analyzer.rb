NameAndVersion = Struct.new(:name, :version)

class OneGemAnalyzer
    # return the names of the dependency gems for a given gem
    def self.find_dependencies_of(gem_name, all_gems)
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
