# Truncates

This Gem allows you to set a field to automatically be truncated to a specific length before validatioin.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'truncates'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install truncates

## Usage

```ruby
class Address < ActiveRecord::Base
  truncates :city, max_length: 30, character_trail: "..."
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/truncates/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
