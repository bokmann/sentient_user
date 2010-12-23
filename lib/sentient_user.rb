module SentientUser
  
  def self.included(base)
    base.class_eval {
      def self.current
        Thread.current[:user]
      end

      def self.current=(o)
        raise(ArgumentError,
            "Expected an object of class '#{self}', got #{o.inspect}") unless (o.is_a?(self) || o.nil?)
        Thread.current[:user] = o
      end
  
      def make_current
        Thread.current[:user] = self
      end

      def current?
        !Thread.current[:user].nil? && self.id == Thread.current[:user].id
      end
      
      def self.do_as(user, &block)
        old_user = self.current
        self.current = user
        response = block.call unless block.nil?
        self.current = old_user
        response
      end
    }
  end
end

module SentientController
  def self.included(base)
    base.class_eval {
      before_filter do |c|
        User.current = c.send(:current_user)
      end
    }
  end
end