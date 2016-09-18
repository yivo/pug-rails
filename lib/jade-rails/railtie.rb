# frozen_string_literal: true
module Jade
  class Railtie < Rails::Engine
    config.jade               = Jade.config
    config.jade.pretty        = Rails.env.development?
    config.jade.compile_debug = Rails.env.development?

    config.before_initialize do |app|
      register_template = -> (env) { (env || app.assets).register_engine('.jade',  Jade::Template) }
      if app.config.assets.respond_to?(:configure)
        app.config.assets.configure { |env| register_template.call(env) }
      else
        register_template.call(nil)
      end
    end
  end
end
