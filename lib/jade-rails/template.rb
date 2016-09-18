# frozen_string_literal: true
require 'tilt'
module Jade
  class Template < Tilt::Template
    def prepare
    end

    def evaluate(context, locals, &block)
      Jade.compile(data, filename: file, client: true)
    end
  end
end
