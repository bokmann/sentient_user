require 'rails'
class Railtie < Rails::Railtie
  initializer 'sentient_user.ar_extensions' do |app|
    ActiveRecord::Base.extend SentientUser
  end
end