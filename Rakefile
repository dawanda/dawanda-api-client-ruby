require 'rubygems'
require 'rake/gempackagetask'
require 'rake/testtask'

task :default => :test


Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

namespace :doc do

  desc 'generate doc'
  task :generate do
    `rdoc`
  end
  
  desc 'clean up all docs'
  task :clean do
    `rm -fr doc`
  end
  
  desc 'open docs in browser'
  task :open do
    `open doc/index.html`
  end
end


begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "dawanda_client"
    gemspec.summary = "Provides a friendly ruby-like interface to the Dawanda API"
    gemspec.description = "Provides a friendly ruby-like interface to the Dawanda API"
    gemspec.email = 'info@christophbuente.de'
    gemspec.homepage = "http://github.com/dawanda/dawanda_client"
    gemspec.authors = ['Christoph Bünte']
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
