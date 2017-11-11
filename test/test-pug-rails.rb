# encoding: UTF-8
# frozen_string_literal: true

require_relative "test-helper"

class PugRailsTest < Test::Unit::TestCase
  def test_registration
    app = create_rails_application
    app.initialize!

    if app.assets.respond_to?(:transformers)
      assert app.assets.transformers.fetch("text/x-pug").fetch("application/javascript+function") \
             == Pug::Sprockets::Transformer
      assert app.assets.transformers.fetch("text/x-jade").fetch("application/javascript+function") \
             == Jade::Sprockets::Transformer
    end

    if app.assets.respond_to?(:engines)
      assert app.assets.engines.fetch(".pug")  == Pug::Sprockets::Transformer
      assert app.assets.engines.fetch(".jade") == Jade::Sprockets::Transformer
    end

    File.join(Gem::Specification.find_by_name("pug-ruby").gem_dir, "vendor").tap do |path|
      assert app.assets.paths.include?(path)
    end
  end

  def test_compilation
    app = create_rails_application
    app.initialize!

    task = create_sprockets_task(app)
    task.instance_exec { manifest.compile(assets) }

    File.expand_path("../fixtures/javascripts/application-1.js.expected", __FILE__).tap do |path|
      assert_equal File.read(path).squish, app.assets["application-1.js"].to_s.squish
    end
  end

  # rubocop:disable Lint/AmbiguousRegexpLiteral
  def test_runtime
    app = create_rails_application
    app.initialize!

    task = create_sprockets_task(app)
    task.instance_exec { manifest.compile(assets) }

    assert_match /pug_escape/,  app.assets["application-2.js"].to_s
    assert_match /jade_escape/, app.assets["application-2.js"].to_s
  end
end
