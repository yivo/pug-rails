## Pug/Jade template engine integration with Rails asset pipeline

## About
This gem uses [pug-ruby](https://github.com/yivo/pug-ruby) to compile Pug/Jade templates. Please refer to that gem if you want to use Pug/Jade compiler directly.

## Installing gem
Add to your Gemfile:
```ruby
gem 'pug-rails', '~> 2.0'
```

## Installing Jade
Install Jade globally via npm:
```bash
npm install -g jade
```

Require Jade runtime.js:
```js
//= require jade/runtime
```

Use `.jst.jade` as extension of your Jade files.

## Installing Pug
Install Pug globally via npm:
```bash
npm install -g pug-cli
```

Require Pug runtime.js:
```js
//= require pug/runtime
```
NOTE: You don't need to do this if you are inlining Pug runtime functions in template. Please read about `inlineRuntimeFunctions` option at official website — [pugjs.org](http://pugjs.org).

Use `.jst.pug` as extension of your Pug files.

## Configuring Pug and Jade
Access Pug and Jade configurations directly:
```ruby
Jade.config.compile_debug = false
Pug.config.compile_debug  = false
```

Access Pug and Jade configurations through `Rails.application.config`:
```ruby
Rails.application.config.jade.compile_debug = false
Rails.application.config.pug.compile_debug  = false
```

## Configuring asset lookup paths
It doesn't matter where to put Pug/Jade files but don't forget to update asset lookup paths. 
Personally I prefer to put templates in `app/assets/templates`:
```ruby
# Add app/assets/templates to asset lookup paths
# Add this to your initializers or application.rb
Rails.application.config.assets.paths << Rails.root.join('app/assets/templates')
```

## Running Tests
Refer to [pug-ruby](https://github.com/yivo/pug-ruby)

## Versioning
Prior to version 2.0 version of the gem was the same as the version of the Jade runtime that it contains.
