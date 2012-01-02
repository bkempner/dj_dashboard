require File.expand_path("../lib/dj_dashboard/version", __FILE__)

# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "dj_dashboard"
  s.version = DjDashboard::VERSION
  s.authors = ["Ben Kempner"]
  s.email = ["ben.kempner@gmail.com"]
  s.homepage = "http://www.github.com/bkempner/dj_dashboard"
  s.summary = "Delayed Job Dashboard"
  s.description = "Delayed Job Dashboard"
  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "haml"
  s.add_dependency "sass"
  s.add_dependency "delayed_job"
  s.add_dependency "will_paginate"
  s.add_dependency "rails", '~> 3.0'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "rr"
  s.add_development_dependency "machinist", "~> 1.0"
  s.add_development_dependency "faker"
end
