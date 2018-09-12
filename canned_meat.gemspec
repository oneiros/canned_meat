$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "canned_meat/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "canned_meat"
  s.version     = CannedMeat::VERSION
  s.authors     = ["David Roetzel"]
  s.email       = ["david@roetzel.de"]
  s.homepage    = "none yet"
  s.summary     = "Summary of CannedMeat."
  s.description = "Description of CannedMeat."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.1"
  s.add_dependency "haml", "~> 4.0.6"
  s.add_dependency "sass-rails", "~> 5.0"
  s.add_dependency "redcarpet", "~> 3.2.3"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 3.2.1"
  s.add_development_dependency "factory_girl_rails", "~> 4.5.0"
  s.add_development_dependency "guard-rspec", "~> 4.5.0"
  s.add_development_dependency "capybara", "~> 2.4.4"
end
