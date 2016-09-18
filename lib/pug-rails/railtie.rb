# frozen_string_literal: true
module Pug
  class Railtie < Rails::Engine
    config.pug               = Pug.config
    config.pug.pretty        = Rails.env.development?
    config.pug.compile_debug = Rails.env.development?

    config.before_initialize do |app|
      register_template = -> (env) { (env || app.assets).register_engine('.pug',  Pug::Template) }
      if app.config.assets.respond_to?(:configure)
        app.config.assets.configure { |env| register_template.call(env) }
      else
        register_template.call(nil)
      end
    end
  end
end
