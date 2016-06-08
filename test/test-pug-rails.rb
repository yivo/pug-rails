# frozen_string_literal: true
require 'pug-rails'
require 'test/unit'

class PugTest < Test::Unit::TestCase
  DOCTYPE_PATTERN               = /^\s*<!DOCTYPE html>/
  PUG_TEMPLATE_FUNCTION_PATTERN = /^function\s+template\s*\(locals\)\s*\{.*\}$/m

  def test_compile
    template = File.read(File.expand_path('../assets/javascripts/pug/sample_template.jade', __FILE__))
    result   = Pug.compile(template)
    assert_match(PUG_TEMPLATE_FUNCTION_PATTERN, result)
    assert_no_match(DOCTYPE_PATTERN, result)
  end

  def test_compile_with_io
    io = StringIO.new('lorem ipsum dolor')
    assert_equal Pug.compile('lorem ipsum dolor'), Pug.compile(io)
  end

  def test_compilation_error
    assert_raise Pug::CompileError do
      Pug.compile <<-JADE
        else
          .foo
      JADE
    end
  end

  def test_includes
    file     = File.expand_path('../assets/javascripts/pug/includes/index.jade', __FILE__)
    template = File.read(file)
    result   = Pug.compile(template, filename: file)
    assert_match(PUG_TEMPLATE_FUNCTION_PATTERN, result)
    assert_no_match(DOCTYPE_PATTERN, result)
  end

  def test_extends
    file     = File.expand_path('../assets/javascripts/pug/extends/layout.jade', __FILE__)
    template = File.read(file)
    result   = Pug.compile(template, filename: file)
    assert_match(PUG_TEMPLATE_FUNCTION_PATTERN, result)
    assert_no_match(DOCTYPE_PATTERN, result)
  end
end
