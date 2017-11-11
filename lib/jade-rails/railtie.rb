# encoding: UTF-8
# frozen_string_literal: true

module Jade
  # :nodoc:
  class Railtie < Rails::Railtie
    config.jade               = Jade.config
    config.jade.pretty        = Rails.env.development?
    config.jade.compile_debug = Rails.env.development?

    initializer "sprockets.jade.transformer", after: "sprockets.environment", group: :all do |app|
      access_assets_environment app do |env|
        # Sprockets 2.x, 3.x, and 4.x.
        # https://github.com/rails/sprockets/blob/master/guides/extending_sprockets.md#registering-all-versions-of-sprockets-in-processors
        if env.respond_to?(:register_transformer)
          env.register_mime_type   "text/x-jade", extensions: [".jade"]
          env.register_transformer "text/x-jade", "application/javascript+function", Jade::Sprockets::Transformer
        end

        if env.respond_to?(:register_engine)
          args = [".jade", Jade::Sprockets::Transformer]
          args << { mime_type: "text/x-jade", silence_deprecation: true } if ::Sprockets::VERSION.start_with?("3")
          env.register_engine(*args)
        end
      end
    end

    initializer "sprockets.jade.paths", after: :append_assets_path, group: :all do |app|
      access_assets_config app do |assets|
        File.join(Gem::Specification.find_by_name("pug-ruby").gem_dir, "vendor").tap do |path|
          assets.paths << path unless assets.paths.include?(path)
        end
      end
    end

  private

    def access_assets_config(app)
      yield app.config.assets
    end

    def access_assets_environment(app)
      if config.respond_to?(:assets) && config.assets.respond_to?(:configure)
        # Rails 4.x and 5.x.
        config.assets.configure { |env| yield env }
      else
        # Rails 3.x.
        yield app.assets
      end
    end
  end
end
