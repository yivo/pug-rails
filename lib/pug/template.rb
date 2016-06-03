module Pug
  class Template < Tilt::Template
    def prepare
    end

    def evaluate(context, locals, &block)
      options = { }
      options[:filename] = file
      jade_config = Rails.application.config.pug.merge(options)
      Pug.compile(data, jade_config)
    end
  end
end
