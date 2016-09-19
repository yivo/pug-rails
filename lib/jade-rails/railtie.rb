# frozen_string_literal: true
module Jade
  class Railtie < Rails::Engine
    config.jade               = Jade.config
    config.jade.pretty        = Rails.env.development?
    config.jade.compile_debug = Rails.env.development?

    def configure_assets(app)
      if config.respond_to?(:assets) && config.assets.respond_to?(:configure)
        # Rails 4.x
        config.assets.configure { |env| yield(env) }
      else
        # Rails 3.2
        yield(app.assets)
      end
    end

    initializer 'sprockets.jade', group: :all, after: 'sprockets.environment' do |app|
      configure_assets(app) do |env|
        # Sprockets 2, 3, and 4
        if env.respond_to?(:register_transformer)
          env.register_mime_type 'text/x-jade', extensions: ['.jade']
          env.register_transformer 'text/x-jade', 'application/javascript', Jade::SprocketsTransformer
        end

        if env.respond_to?(:register_engine)
          args = ['.jade', Jade::SprocketsTransformer]
          args << { mime_type: 'text/x-jade', silence_deprecation: true } if Sprockets::VERSION.start_with?('3')
          env.register_engine(*args)
        end
      end
    end
  end
end
