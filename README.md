This application analyzes all the gems from RubyGems.org to find the most useful gems.

The task breakdown of this project would be:

* Download http://rubygems.org:80/latest_specs.4.8.gz to get a list of all the gems.
* Gunzip and unmarshal the data
* Go over each gem one by one. For each gem, use the 'gems' gem to get the dependency list from the gemspec
* Build a dependency graph of all the gems, each node being a gem+version. (I'll need to ponder if I should use a node for each specific version or only the major.minor versions)
* Analyze the graph to find the core gems, ie the gems that are mostly dependent on by other gems
* Have some UI (either interactive or static) to present the results
* Deploy this app to some server and schedule a cron job or something so the data can be analyzed on a daily/weekly basis etc.

Where am I at?

So far, I've ignored gem versions when analyzing gem dependencies. I'll need to find out what's the best way to handle gem dependencies like (>=, ~> etc). The app now can give you a list of top 50 mostly used gems.
