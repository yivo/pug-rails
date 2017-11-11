# encoding: UTF-8
# frozen_string_literal: true

Bundler.require :default, :development

require "sprockets/railtie"
require "fileutils"

module TestHelper
  def self.included(base)
    base.setup do
      clear_tmp
      clear_logs
    end

    base.teardown do
      clear_tmp
      if defined?(Rails) && Rails.respond_to?(:application=)
        Rails.application = nil
      end
    end
  end

  def create_rails_application
    Class.new(Rails::Application) do
      config.eager_load                 = false
      config.assets.enabled             = true
      config.assets.gzip                = false
      config.assets.paths               = [Rails.root.join("test/fixtures/javascripts").to_s]
      config.assets.precompile          = []
      config.paths["public"]            = [Rails.root.join("tmp").to_s]
      config.active_support.deprecation = :stderr
      config.pug.compile_debug          = false
      config.jade.compile_debug         = false
      config.pug.pretty                 = false
      config.jade.pretty                = false
    end
  end

  def create_sprockets_task(app)
    require "sprockets/version" # Fix for sprockets 2.x

    if Sprockets::VERSION.start_with?("2")
      require "rake/sprocketstask"
      Rake::SprocketsTask.new do |t|
        t.environment = app.assets
        t.output      = "#{ app.config.paths["public"].to_a[0] }#{ app.config.assets.prefix }"
        t.assets      = app.config.assets.precompile
      end
    else
      require "sprockets/rails/task"
      Sprockets::Rails::Task.new(app)
    end
  end

  def clear_tmp
    FileUtils.rm_rf(File.expand_path("../../tmp", __FILE__))
  end

  def clear_logs
    FileUtils.rm_rf(File.expand_path("../../log", __FILE__))
  end
end

Test::Unit::TestCase.send :include, TestHelper
