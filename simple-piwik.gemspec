# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{simple-piwik}
  s.version = "0.5.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{mihael}]
  s.date = %q{2011-08-19}
  s.description = %q{Provides simple access to the Piwik API.}
  s.email = %q{mihael.ploh@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/piwik/base.rb",
    "lib/piwik/site.rb",
    "lib/piwik/trackable.rb",
    "lib/piwik/user.rb",
    "lib/simple-piwik.rb",
    "script/console",
    "simple-piwik.gemspec",
    "test/files/config/example_piwik.yml",
    "test/simple-piwik_test.rb",
    "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/mihael/simple-piwik}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{A ruby client for the Piwik API.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.8"])
      s.add_runtime_dependency(%q<rest-client>, [">= 1.6.1"])
      s.add_runtime_dependency(%q<json>, [">= 1.4.6"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.8"])
      s.add_dependency(%q<rest-client>, [">= 1.6.1"])
      s.add_dependency(%q<json>, [">= 1.4.6"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.8"])
    s.add_dependency(%q<rest-client>, [">= 1.6.1"])
    s.add_dependency(%q<json>, [">= 2.3.8"])
  end
end

