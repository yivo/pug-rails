## 👌 Make Jade and Pug play well with Sprockets

[![Gem Version](https://badge.fury.io/rb/pug-rails.svg)](https://badge.fury.io/rb/pug-rails)
[![Build Status](https://travis-ci.org/yivo/pug-rails.svg?branch=master)](https://travis-ci.org/yivo/pug-rails)

## About

`pug-rails` is a gem that allows you to easily integrate Jade / Pug template engine with Rails asset packaging system known as Sprockets.

[pug-ruby](https://github.com/yivo/pug-ruby) is used under the hood. Please refer to the gem if you would like to use Jade / Pug compiler API directly.

## Installing gem

**RubyGems users**

1. Run `gem install pug-rails --version "~> 3.0.0"`. 
2. Add `require "pug-rails"` to your code.

**Bundler users**

1. Add to your Gemfile:
```ruby
gem "pug-rails", "~> 3.0.0"
```
2. Run `bundle install`.

## Installing Jade and Pug

See installation steps and notes at [pug-ruby](https://github.com/yivo/pug-ruby#installing-jade). You may not need to do this step.

## Requiring Jade runtime

Put the next line in your asset manifest:
```js
//= require jade-runtime-1.11.0
```

You may change Jade runtime.js version depending on your scenario.

## Naming Jade templates

Use `.jst.jade` as extension of your Jade files.

## Requiring Pug runtime

Put the next line in your asset manifest:
```js
//= require pug-runtime-2.0.2
```

You may change Pug runtime.js version depending on your scenario.

**IMPORTANT:** You don't need to do this if you have configured Pug compiler to inline runtime functions in template. Please read about `inlineRuntimeFunctions` option at official website: [pugjs.org](http://pugjs.org).

## Naming Pug templates

Use `.jst.pug` as extension of your Pug files.

## Configuring Jade / Pug

Configuration documentation is available at [pug-ruby](https://github.com/yivo/pug-ruby#configuring-jade--pug).

## Configuring asset lookup paths

It doesn't matter where to put Jade / Pug files but don't forget to update asset lookup paths. 
Personally I prefer to put templates in `app/assets/templates`:
```ruby
# This will add app/assets/templates to asset lookup paths.
#
# Add the next line to your initializers or application.rb:
Rails.application.config.assets.paths << Rails.root.join("app/assets/templates")
```

## Running tests

1. Install both Jade and Pug: `npm install --global jade pug`.
2. Install gem dependencies: `bundle install`.
3. Finally, run tests: `bundle exec appraisal rake test`.

## Versioning

Prior to 2.0 the version of the gem was the same as the version of the Jade runtime that it contained.
