require 'rubygems'
require 'test/unit'
require 'shoulda'

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
