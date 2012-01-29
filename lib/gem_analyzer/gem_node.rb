# This class represents a gem. Each gem has a list of 
# dependencies and a list of consumers.
require "set"

module GemAnalyzer
  class GemNode
    attr_reader :name, :version, :dependencies, :consumers

    def initialize(name, version = 0)
      @name = name
      @version = version
      @dependencies = Set.new
      @consumers = Set.new
    end

    def add_dependency(dep)
      @dependencies << dep
    end

    def add_consumer(consumer)
      @consumers << consumer
    end

    def has_deps_or_consumers?
      @dependencies.size != 0 || @consumers.size != 0
    end

    def to_s
      format = "GemNode: \n\tname=%s, \n\tversion=%s, \n\tdeps=%s, " +
        "\n\tconsumers=%s"
      deps = dependencies.inject([]) do |list|
        list << "#{d.name}{#{d.version}}"
      end
      cons = consumers.inject([]) do |list|
        list << "#{c.name}{#{c.version}}"
      end
      format % [name, version, deps, cons]
    end

    # A node is greater if it has a longer list of consumers because
    # here we are trying to find the mostly used gems.
    def <=>(other)
      raise TypeError unless other.respond_to?(:consumers)

      consumers.size <=> other.consumers.size
    end

    def ==(other)
      name == other.name && version == other.version
    end

    def eql?(other)
      self == other
    end

    def hash
      [name, version].hash
    end
  end
end
