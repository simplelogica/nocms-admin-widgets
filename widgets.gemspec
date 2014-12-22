$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "no_cms/admin/widgets/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nocms-admin-widgets"
  s.version     = NoCms::Admin::Widgets::VERSION
  s.authors     = ["Luis Mendo"]
  s.email       = ["luis@simplelogica.net"]
  s.homepage    = "https://github.com/simplelogica/nocms-admin-widgets"
  s.summary     = "Gem with custom back for nocms-widgets gem"
  s.description = "Gem with custom back for nocms-widgets gem"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "nocms-widgets", '~> 0.0', '>= 0.0.1'
  s.add_dependency "nocms-admin", '~> 0.0', '>= 0.0.1'
  s.add_dependency "jquery-rails", '~> 3.1'

  s.add_development_dependency "sqlite3"
end
