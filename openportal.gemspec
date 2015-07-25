$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'openportal/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'openportal'
  s.version     = Openportal::VERSION
  s.authors     = ['Victor Campos']
  s.email       = ['victorcampos@ufrj.br']
  s.homepage    = ''
  s.summary     = 'Summary of Openportal.'
  s.description = 'Description of Openportal.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2.1'

  s.add_dependency 'axlsx_rails'
  s.add_dependency 'whenever'
  s.add_dependency 'simple_form'
  s.add_dependency 'cocoon'
  s.add_dependency 'compass-rails'
  s.add_dependency 'chosen-rails'
  s.add_dependency 'ransack'
  s.add_dependency 'kaminari'
  s.add_dependency 'devise'
  s.add_dependency 'rails-i18n'
  s.add_dependency 'sass-rails'
  s.add_dependency 'rpush'
  s.add_dependency 'jquery-turbolinks'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'brakeman'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'metric_fu'
  s.add_development_dependency 'byebug'
end
