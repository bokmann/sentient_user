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

  should "allow execution of a block as a specified user" do
    p, p2 = Person.new, Person.new
    p.make_current
    Person.do_as(p2) { assert_equal Person.current, p2 }
  end

  should "should reset the original user after executing a block as a specified user" do
    p, p2 = Person.new, Person.new
    p.make_current

    Person.do_as(p2) { }
    assert_equal Person.current, p

    begin
      Person.do_as(p2) { raise "error" }
    rescue
      assert_equal Person.current, p
    end
  end
  
  # We don't want to allow this because it would allow for a false sense that things will work, even though
  # they won't.  If you don't add the registered type, the controller won't ever store that current_object
  # in Thread.current, and if later code expects it to be there it will fail.
  should "not allow calls to be_sentient for unregistered types" do
    assert_raise ArgumentError do
      class UnregisteredType
        extend SentientUser
        be_sentient
      end
    end
  end

  should "have no spelling errors in its README" do
    check_spelling_in_file "README.rdoc"
  end

  should "have no spelling errors in the license" do
    check_spelling_in_file "LICENSE"
  end
end
