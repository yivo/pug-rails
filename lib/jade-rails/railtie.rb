# encoding: utf-8
# frozen_string_literal: true

require 'rails/railtie'

module Jade
  class Railtie < Rails::Railtie
    config.jade               = Jade.config
    config.jade.pretty        = Rails.env.development?
    config.jade.compile_debug = Rails.env.development?

    initializer 'sprockets.jade.transformer', after: 'sprockets.environment', group: :all do |app|
      access_assets_environment app do |env|
        # Sprockets 2, 3, and 4
        if env.respond_to?(:register_transformer)
          env.register_mime_type 'text/x-jade', extensions: ['.jade']
          env.register_transformer 'text/x-jade', 'application/javascript', Jade::Sprockets::Transformer
        end

        if env.respond_to?(:register_engine)
          args = ['.jade', Jade::Sprockets::Transformer]
          args << { mime_type: 'text/x-jade', silence_deprecation: true } if ::Sprockets::VERSION.start_with?('3')
          env.register_engine(*args)
        end
      end
    end

    initializer 'sprockets.jade.runtime', after: 'sprockets.environment', group: :all do |app|
      access_assets_config app do |assets|
        assets.precompile += %w( jade/runtime.js )
        assets.paths      += [File.expand_path('../../../vendor/assets/javascripts', __FILE__)]
      end
    end

  private
    def access_assets_config(app)
      if config.respond_to?(:assets) && config.assets.respond_to?(:configure)
        # Rails 4.x 5.x
        yield config.assets
      else
        # Rails 3.2
        yield app.assets
      end
    end

    def access_assets_environment(app)
      if config.respond_to?(:assets) && config.assets.respond_to?(:configure)
        # Rails 4.x 5.x
        config.assets.configure { |env| yield env }
      else
        # Rails 3.2
        yield app.assets
      end
    end
  end
end
