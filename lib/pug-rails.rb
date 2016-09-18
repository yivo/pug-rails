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

Jade.runtime_version = '1.11.0'
Pug.runtime_version  = '2.0.2'

require 'pug-ruby'
require 'pug-rails/template'
require 'pug-rails/railtie'
require 'jade-rails/template'
require 'jade-rails/railtie'
