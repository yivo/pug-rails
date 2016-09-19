# frozen_string_literal: true
module Pug
  class Railtie < Rails::Engine
    config.pug               = Pug.config
    config.pug.pretty        = Rails.env.development?
    config.pug.compile_debug = Rails.env.development?

    def configure_assets(app)
      if config.respond_to?(:assets) && config.assets.respond_to?(:configure)
        # Rails 4.x
        config.assets.configure { |env| yield(env) }
      else
        # Rails 3.2
        yield(app.assets)
      end
    end

    initializer 'sprockets.pug', group: :all, after: 'sprockets.environment' do |app|
      configure_assets(app) do |env|
        # Sprockets 2, 3, and 4
        if env.respond_to?(:register_transformer)
          env.register_mime_type 'text/x-pug', extensions: ['.pug']
          env.register_transformer 'text/x-pug', 'application/javascript+function', Pug::SprocketsTransformer
        end

        if env.respond_to?(:register_engine)
          args = ['.pug', Pug::SprocketsTransformer]
          args << { mime_type: 'text/x-pug', silence_deprecation: true } if Sprockets::VERSION.start_with?('3')
          env.register_engine(*args)
        end
      end
    end
  end
end
