# frozen_string_literal: true
module Pug
  module Sprockets
    # Sprockets 2, 3 & 4 interface
    # https://github.com/rails/sprockets/blob/master/guides/extending_sprockets.md#registering-all-versions-of-sprockets-in-processors
    class Transformer
      def initialize(filename, &block)
        @filename = filename
        @source   = block.call
      end

      def render(context, empty_hash_wtf)
        self.class.run(@filename, @source, context)
      end

      def self.run(filename, source, context)
        Pug.compile(source, filename: filename, client: true)
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
