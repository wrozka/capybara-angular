# Capybara::Angular
[![Build Status](https://travis-ci.org/wrozka/capybara-angular.svg?branch=master)](https://travis-ci.org/wrozka/capybara-angular)
[![Gem Version](https://badge.fury.io/rb/capybara-angular.svg)](http://badge.fury.io/rb/capybara-angular)

Capybara API that knows how to wait for Angular in end to end specs.

## Installation

Add this line to your application's Gemfile:

    gem 'capybara-angular'

## Usage

Use it as you would use regular Capybara API, however this time, you won't face any race conditions when working with AngularJS applications.

```ruby
include Capybara::Angular::DSL
```

If you need to run some code without caring about AngularJS, you can use `ignoring_angular` like this:
```ruby
ignoring_angular do
  # Your AngularJS agnostic code goes here
end
```

## Limitations

At the moment it works with AngularJS applications initialized with `ng-app`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
