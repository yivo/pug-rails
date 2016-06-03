# Ruby on Rails integration with Jade

## How it works
This gem compiles Jade templates with [command line tool](http://jade-lang.com/command-line).

There are support of all basic features including advanced:
* [Jade includes](http://jade-lang.com/reference/includes)
* [Jade extends](http://jade-lang.com/reference/extends)
* [Jade inheritance](http://jade-lang.com/reference/inheritance)

Jade template can be alternatively compiled using [command line](http://jade-lang.com/command-line). This method is impemented in this fork.

## Installing
Install Jade globally via npm:
```bash
npm install -g jade
```

Add to your Gemfile:
```ruby
gem 'pug-rails', '~> 1.0'
```

Require Jade runtime.js:
```js
//= require jade/runtime
```

## Running Tests
```bash
bundle exec rake test
```

## Versioning
Gem version always reflects the version of Jade it contains.
