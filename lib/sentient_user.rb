require 'request_store'

module SentientUser

  def self.included(base)
    base.class_eval {
      def self.current
        RequestStore.store[:user]
      end

      def self.current=(o)
        raise(ArgumentError,
            "Expected an object of class '#{self}', got #{o.inspect}") unless (o.is_a?(self) || o.nil?)
        RequestStore.store[:user] = o
      end

      def make_current
        RequestStore.store[:user] = self
      end

      def current?
        !RequestStore.store[:user].nil? && self.id == RequestStore.store[:user].id
      end

      def self.do_as(user, &block)
        old_user = self.current

        begin
          self.current = user
          response = block.call unless block.nil?
        ensure
          self.current = old_user
        end

        response
      end
    }
  end
end

module SentientController
  def self.included(base)
    base.class_eval {
      before_action do |c|
        User.current = c.send(:current_user)
      end
    }
  end
end
