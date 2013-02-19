require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = "simple-piwik"
    gem.summary     = %Q{A ruby client for the Piwik API.}
    gem.description = %Q{Provides simple access to the Piwik API.}
    gem.email       = "mihael.ploh@gmail.com"
    gem.homepage    = "http://github.com/mihael/simple-piwik"
    gem.authors     = ["mihael"]
    gem.add_dependency "activesupport", ">= 2.3.8"
    gem.add_dependency "rest-client",   ">= 1.6.1"
    gem.add_dependency "json",          ">= 1.4.6"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :test => :check_dependencies

task :default => :test


