# frozen_string_literal: true
Gem::Specification.new do |s|
  s.name            = 'pug-rails'
  s.version         = '2.0.2'
  s.author          = 'Yaroslav Konoplov'
  s.email           = 'eahome00@gmail.com'
  s.summary         = 'Pug/Jade template engine integration with Rails asset pipeline.'
  s.description     = 'Pug/Jade template engine integration with Rails asset pipeline.'
  s.homepage        = 'https://github.com/yivo/pug-rails'
  s.license         = 'MIT'

  s.executables     = `git ls-files -z -- bin/*`.split("\x0").map{ |f| File.basename(f) }
  s.files           = `git ls-files -z`.split("\x0")
  s.test_files      = `git ls-files -z -- {test,spec,features}/*`.split("\x0")
  s.require_paths   = ['lib']

  s.add_dependency 'pug-ruby', '~> 1.0'
end
