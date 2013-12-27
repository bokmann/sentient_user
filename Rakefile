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


require File.expand_path('../lib/sentient_user/version.rb', __FILE__)
