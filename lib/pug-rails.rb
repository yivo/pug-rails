# encoding: utf-8
# frozen_string_literal: true

module Jade
  class << self
    attr_accessor :runtime_version
  end
end

module Pug
  class << self
    attr_accessor :runtime_version
  end
end

# https://github.com/pugjs/pug/blob/v1.x.x/runtime.js
Jade.runtime_version = '1.11.0'

# https://github.com/pugjs/pug-runtime
Pug.runtime_version  = '2.0.2'

require 'pug-ruby'

require 'pug-rails/sprockets/transformer'
require 'pug-rails/railtie'

require 'jade-rails/sprockets/transformer'
require 'jade-rails/railtie'
