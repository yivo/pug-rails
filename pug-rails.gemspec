# frozen_string_literal: true
Gem::Specification.new do |s|
  s.name            = 'pug-rails'
  s.version         = '2.0.0'
  s.author          = 'Yaroslav Konoplov'
  s.email           = 'eahome00@gmail.com'
  s.summary         = 'Rails asset pipeline wrapper for the Pug/Jade template engine.'
  s.description     = 'Rails asset pipeline wrapper for the Pug/Jade template engine.'
  s.homepage        = 'https://github.com/yivo/pug-rails'
  s.license         = 'MIT'

  s.executables     = `git ls-files -z -- bin/*`.split("\x0").map{ |f| File.basename(f) }
  s.files           = `git ls-files -z`.split("\x0")
  s.test_files      = `git ls-files -z -- {test,spec,features}/*`.split("\x0")
  s.require_paths   = ['lib']

  s.add_dependency 'pug-ruby', '~> 1.0.0'
  s.add_dependency 'tilt', '~> 2.0.0'
end
