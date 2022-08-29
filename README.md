# Kisyo

A ruby tool for getting weather information from www.data.jma.go.jp

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kisyo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kisyo

## Usage

```ruby
require 'kisyo'

location = Kisyo::location.nearest(35.6809591, 139.7673068)
daily = Kisyo::Daily.new(location)
date = Date.parse('2016-11-02')
daily.at(date)
```

## Contributing

1. Fork it ( https://github.com/youpy/kisyo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
