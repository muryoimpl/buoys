$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "buoys/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "buoys"
  s.version     = Buoys::VERSION
  s.authors     = ["muryoimpl"]
  s.email       = ["muryoimpl@gmail.com"]
  s.homepage    = "https://github.com/muryoimpl/buoys"
  s.summary     = "A Ruby on Rails breadcrumbs plugin."
  s.description = "A Ruby on Rails breadcrumbs plugin."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 5.2.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry-rails"
  s.add_development_dependency "rubocop", "~> 0.54"
end
