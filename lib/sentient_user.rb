require 'sentient_user/railtie'

module SentientUser

  mattr_accessor :sentient_types
  @@sentient_types = [:user]

  def self.setup
    yield self
  end

  # where type is a symbol indicating one of the sentient_types as specified in the config, i.e. :user
  def be_sentient
    type = self.name.underscore.to_sym
    raise(ArgumentError, 
          "#{type} is not a pre-registered sentient type.  Expected one of [#{SentientUser.sentient_types.join(', ')}]") unless SentientUser.sentient_types.include?(type)
    self.class_eval <<-EVAL

      def self.current
        Thread.current[:#{type}]
      end

      def self.current=(o)
        raise(ArgumentError,
              "Expected an object of class '\#{self}', got \#{o.inspect}") unless (o.is_a?(self) || o.nil?)
        Thread.current[:#{type}] = o
      end

      def make_current
        Thread.current[:#{type}] = self
      end

      def current?
        !Thread.current[:#{type}].nil? && self.id == Thread.current[:#{type}].id
      end

      def self.do_as(object, &block)
        old_object = self.current

        begin
          self.current = object
          response = block.call unless block.nil?
        ensure
          self.current = old_object
        end

        response
      end
    EVAL
  end

end

module SentientController

  # call this in your controller as a before filter.  It should be called
  # after your types are authenticated, but before any other filters in case
  # those filters do anything worth tracking.
  def store_sentient_types
    SentientUser.sentient_types.each do |type|
      clazz = Module.const_get(type.to_s.camelize)
      clazz.current = self.send("current_#{type}".to_sym)
    end
  end

  # Optional after_filter that just sets the current value to nil
  def clear_sentient_types
    SentientUser.sentient_types.each do |type|
      clazz = Module.const_get(type.to_s.camelize)
      clazz.current = nil
    end
  end

end