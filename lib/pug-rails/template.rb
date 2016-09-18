# frozen_string_literal: true
require 'tilt'
module Pug
  class Template < Tilt::Template
    def prepare
    end

    def evaluate(context, locals, &block)
      Pug.compile(data, filename: file, client: true)
    end
  end
end
