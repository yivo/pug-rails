# frozen_string_literal: true
module Pug
  class Railtie < Rails::Engine
    config.pug               = ActiveSupport::OrderedOptions.new
    config.pug.executable    = Pug.find_executable
    config.pug.pretty        = Rails.env.development?
    config.pug.self          = false
    config.pug.compile_debug = Rails.env.development?
    config.pug.globals       = []
    config.jade              = config.pug

    config.before_initialize do |app|
      register_jade = -> (env = nil) {
        (env || app.assets).register_engine '.jade', ::Pug::Template
        (env || app.assets).register_engine '.pug',  ::Pug::Template
      }

      if app.config.assets.respond_to?(:configure)
        app.config.assets.configure { |env| register_jade.call(env) }
      else
        register_jade.call
      end
    end
  end
end
