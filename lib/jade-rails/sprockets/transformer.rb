# encoding: UTF-8
# frozen_string_literal: true

require "digest/sha1"

module Jade
  # :nodoc:
  module Sprockets
    class << self
      def compile(source, options = {})
        Jade.compile(source, options)
      end
    end

    #
    # Friendly with sprockets 2.x, 3.x, and 4.x.
    # https://github.com/rails/sprockets/blob/master/guides/extending_sprockets.md#supporting-all-versions-of-sprockets-in-processors
    #
    class Transformer
      def initialize(filename)
        @filename = filename
        @source   = yield
      end

      def render(context, _)
        self.class.run(@filename, @source, context)
      end

      def cache_key
        self.class.cache_key
      end

      def self.run(filename, source, context)
        Jade::Sprockets.compile(source, filename: filename, client: true)
      end

      def self.call(input)
        filename = input[:filename]
        source   = input[:data]
        context  = input[:environment].context_class.new(input)

        result = run(filename, source, context)
        context.metadata.merge(data: result)
      end

      def self.cache_key
        [name,
         PUG_RUBY_GEM_VERSION,
         PUG_RAILS_GEM_VERSION,
         Jade.compiler.version,
         Jade.compiler.class.name,
         Digest::SHA1.hexdigest(Jade.config.to_h.to_a.flatten.map(&:to_s).join(","))
        ].join(":").freeze
      end
    end
  end
end
