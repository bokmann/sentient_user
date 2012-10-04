require 'rubygems'
require 'rake'
require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'rdoc/rdoc'
require 'rdoc/task'


require File.expand_path('../lib/sentient_user/version.rb', __FILE__)

Rake::RDocTask.new do |rdoc|

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "sentient_user #{SentientUser::VERSION}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end