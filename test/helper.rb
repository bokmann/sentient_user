require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'sentient_user'

SentientUser.setup do |config| 
  config.sentient_types = [:user, :person]
end

class Test::Unit::TestCase
end

class Person
  # Normally, this is automatic via the Railtie that adds this method to ActiveRecord::Base.  We only 
  # do the explicit extension for testing.
  extend SentientUser
  be_sentient
end

class User
  extend SentientUser
  be_sentient
end

class AnonymousUser < User ; end

ExceptedWords = %w{ hackery hacky monkeypatching
                    ActiveRecord SentientUser SentientController
                    initializer config rakefile bokmann
                    sublicense MERCHANTABILITY NONINFRINGEMENT
                    img src be_sentient current_ pre
                    }

def check_spelling_in_file(path_relative_to_gem_root)
  path = "#{File.dirname(__FILE__)}/../#{path_relative_to_gem_root}"
  begin
    aspell_output = `cat #{path} | aspell list`
  rescue => err
    warn "You probably don't have aspell. On mac: brew install aspell --lang=en"
    raise err
  end
  noticed_words = aspell_output.split($/)
  misspellings = noticed_words - ExceptedWords
  assert_equal [], misspellings
end
