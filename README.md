# GemAnalyzer

_written by: Jingjing Duan_

# Introduction

This application analyzes all the gems from RubyGems.org to find the gems
that are mostly consumed by other gems. 'json' and 'rake' are 2 good
examples. They are heavily utilized gems. The purpose of this project
is to help the community find useful gems so they don't need to reinvent
the wheels when they start a new project.

# Usage
Launch the analyzer by running `bin/gem_analyzer`. It supports 2 modes.

1. If you want to analyze all the gems (which will take a few hours), simply run `bin/gem_analyzer`.
2. If you want to get a quick feel of how the analyzer works or for debugging purposes, you can run `bin/gem_analyzer num` where `num` is the number of gems you'd like to analyze. The analyzer will randomly pick the `num` of gems out of all the gems and analyze them.

# Implementation

The analyzer works like this:

1. Download file http://rubygems.org:80/latest\_specs.4.8.gz to get a list of
all the latest gems.
2. Gunzip and unmarshal the data.
3. Go over each gem one by one. For each gem, use the 'gems' gem to get
the dependency list from the gemspec.
4. For each consumed gem, add the current gem to its consumer list.
5. Sort the consumed gems according to the size of its consumer list to
find the core gems, ie the gems that are mostly dependent on by other gems.

# Statistics
You can find some statistics under the 'statistics/' directory.

To give you a feel, below is the top 10 consumed gems:

gem json, version: >= 0, consumers: 5635
gem nokogiri, version: >= 0, consumers: 3160
gem activesupport, version: >= 0, consumers: 3110
gem rack, version: >= 0, consumers: 1905
gem rest-client, version: >= 0, consumers: 1698
gem i18n, version: >= 0, consumers: 1558
gem rake, version: >= 0, consumers: 1520
gem httparty, version: >= 0, consumers: 1481
gem thor, version: >= 0, consumers: 1360
gem sinatra, version: >= 0, consumers: 1290

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
 
# License

Copyright (c) 2011 Jingjing Duan

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
