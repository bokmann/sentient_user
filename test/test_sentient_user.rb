require 'helper'

class TestSentientUser < Test::Unit::TestCase
  should "allow making the 'person' class sentient" do
    p = Person.new
    p.make_current
    assert_equal Person.current, p
  end
  
  should "allow making the 'user' class sentient" do
    u = User.new
    u.make_current
    assert_equal User.current, u
  end
  
  should "not allow making Person.current a user" do
    assert_raise ArgumentError do
      Person.current = User.new
    end
  end
  
  should "allow making person.current a person" do
    Person.current = Person.new
  end
  
  should "allow subclasses of user to be assigned to user.current" do
    User.current = AnonymousUser.new
  end
end
