# Introduction

This application analyzes all the gems from RubyGems.org to find the gems
that are mostly consumed by other gems. 'json' and 'rake' are 2 good 
examples. They are heavily utilized gems. The purpose of this project
is to help the community find useful gems so they don't need to reinvent
the wheels when the start a new project.

# Implementation

You can start the analyzer by doing a 'ruby launcher.rb' at the root of the
project. It will analyze all the gems by following the procedure below:

* Download http://rubygems.org:80/latest\_specs.4.8.gz to get a list of 
all the latest gems.
* Gunzip and unmarshal the data.
* Go over each gem one by one. For each gem, use the 'gems' gem to get 
the dependency list from the gemspec.
* For each consumed gem, add the current gem to its consumer list.
* Sort the consumed gems according to the size of its consumer list to 
find the core gems, ie the gems that are mostly dependent on by other gems.

# Statistics
You can find some statistics under the 'statistics/' directory.

# TODO

* Have some UI (either interactive or static) to present the results
* Deploy this app to some server and schedule a cron job or something 
so the data can be analyzed on a daily/weekly basis etc.
* (optional) Have some trending data/graph.
* Find most downloaded gems. We probably want to combine "the most
consumed gems" and "the most downloaded gems" to find the most useful
gems. There are lots of "dead/useless" gems depending on some gems. Those
consumed gems don't necesarily reflect their usefulness.

# Note

Note that the dependencies are expressed like ["bundler", "~>1.0"], 
["bundler", ">1.0"]. This project doesn't try to consolidate them into
one consumed gem. Instead, "~>1.0" and ">1.0" are considered 2 consumed
gems even though they are both bundler.
