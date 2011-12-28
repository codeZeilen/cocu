$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cocu/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cocu"
  s.version     = Cocu::VERSION
  s.authors     = ["Patrick Rein"]
  s.email       = ["patrick.rein@gmail.com"]
  s.homepage    = ""
  s.summary     = "Adds a cucumber formatter which only shows what you really need."
  s.description = "This adds another formater to cucumber which only shows you the features name and passing scenarios. If a scenario fails it shows the failing step and the error. You can call it by specifying the --format cocu option or calling the rake task cucumber:cocu."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1"
  s.add_dependency "cucumber"

  s.add_development_dependency "sqlite3"
end
