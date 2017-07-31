# encoding: UTF-8
# frozen_string_literal: true

module Pug
  module Sprockets
    class << self
      def compile(source, options = {})
        Pug.compile(source, options)
      end
    end

    #
    # Friendly with sprockets 2.x, 3.x, and 4.x.
    # https://github.com/rails/sprockets/blob/master/guides/extending_sprockets.md#registering-all-versions-of-sprockets-in-processors
    #
    class Transformer
      def initialize(filename, &block)
        @filename = filename
        @source   = block.call
      end

      def render(context, _)
        self.class.run(@filename, @source, context)
      end

      def self.run(filename, source, context)
        Pug::Sprockets.compile(source, filename: filename, client: true)
      end

      def self.call(input)
        filename = input[:filename]
        source   = input[:data]
        context  = input[:environment].context_class.new(input)

        result = run(filename, source, context)
        context.metadata.merge(data: result)
      end
    end
  end
end
