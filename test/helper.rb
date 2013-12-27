require 'rubygems'
require 'test/unit'
require "minitest/autorun"
require "minitest/should"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'sentient_user'

class Test::Unit::TestCase
end

class Person
  include SentientUser
end

class User
  include SentientUser
end

class AnonymousUser < User ; end

ExceptedWords = %w{ hackery hacky monkeypatching
                    ActiveRecord SentientUser SentientController
                    initializer config rakefile bokmann
                    sublicense MERCHANTABILITY NONINFRINGEMENT img src
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
