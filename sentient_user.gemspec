# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sentient_user/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["bokmann"]
  gem.email         = ["dbock@codesherpas.com"]
  gem.description   = %q{lets the User model in most authentication frameworks know who is the current user}
  gem.summary       = %q{A trivial bit of common code}
  gem.homepage      = "http://github.com/bokmann/sentient_user"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "sentient_user"
  gem.require_paths = ["lib"]
  gem.version       = SentientUser::VERSION

  gem.add_dependency "railties", ">= 3.1"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rdoc"
  gem.add_development_dependency "minitest", "4.7.5"
  gem.add_development_dependency 'minitest_should'
  gem.add_development_dependency 'turn'

  gem.add_development_dependency "simplecov"

end


