# frozen_string_literal: true
module Pug
  class Template < Tilt::Template
    def prepare
    end

    def evaluate(context, locals, &block)
      jade_config = Rails.application.config.pug.merge(filename: file)
      Pug.compile(data, jade_config)
    end
  end
end
