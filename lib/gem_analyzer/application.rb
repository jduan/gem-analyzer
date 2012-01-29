module GemAnalyzer
  class Application
    # limit is the number of gems to analyze. If limit is nil,
    # all the gems will be analyzed.
    def self.run(limit)
      gem_downloader = GemDownloader.new
      gem_analyzer = Analyzer.new(gem_downloader)
      gem_analyzer.analyze(limit.nil? ? nil : limit.to_i)
    end
  end
end
