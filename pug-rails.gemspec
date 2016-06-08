# frozen_string_literal: true
require File.expand_path('../lib/pug/version', __FILE__)

Gem::Specification.new do |s|
  s.name            = 'pug-rails'
  s.version         = Pug::VERSION
  s.author          = 'Yaroslav Konoplov'
  s.email           = 'yaroslav@inbox.com'
  s.summary         = 'Jade adapter for the Rails asset pipeline.'
  s.description     = 'Jade adapter for the Rails asset pipeline.'
  s.homepage        = 'https://github.com/yivo/pug-rails'
  s.license         = 'MIT'

  s.executables     = `git ls-files -z -- bin/*`.split("\x0").map{ |f| File.basename(f) }
  s.files           = `git ls-files -z`.split("\x0")
  s.test_files      = `git ls-files -z -- {test,spec,features}/*`.split("\x0")
  s.require_paths   = ['lib']

  s.add_dependency 'tilt', '~> 2.0.0'
  s.add_development_dependency 'bundler', '~> 1.7'
  s.add_development_dependency 'rake',    '~> 10.0'
end
