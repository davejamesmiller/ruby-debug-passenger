# ruby-debug-passenger

## Background
I wanted to use Phusion Passenger as an Apache module (not standalone) but still
be able to use the interactive Ruby debugger.

Thanks to
[Adam Meehan](http://duckpunching.com/passenger-mod_rails-for-development-now-with-debugger)
I was able to do that, and I decided to make it into a reusable Gem.

## Requirements
This is been tested on:

* Rails 3.2.2
* Ruby (MRI) 1.9.2
* Old Ruby Debugger 0.11.6
* Phusion Passenger 3.0.11

and

* Rails 3.0.14
* Ruby (MRI) 1.9.3-p125
* Debugger gem 1.1.4
* Phusion Passenger 3.0.12 and 3.0.13

It will probably work on other versions, but not on Rails 2.

It may or may not work on Ruby 1.8.

## Installation
Add this to your `Gemfile` (assuming you are on Ruby 1.9):

```ruby
gem "debugger"
gem "ruby-debug-passenger"
```

or use the old ruby-debug gem:

```ruby
gem "ruby-debug19", require: "ruby-debug"
gem "ruby-debug-passenger"
```

Or if you're using Ruby 1.8 you can try the following, but it hasn't been tested!

```ruby
gem "ruby-debug"
gem "ruby-debug-passenger"
```

Then run `bundle install` to install it.

## Usage
Add `debugger` anywhere in your Ruby code that you want to invoke the debugger.
(Or in an ERB template add `<% debugger %>`.)

Run `rake debug` to restart Phusion Passenger and connect to the debugger. (You
will be prompted to reload the app in your browser.)

## Suggested configuration
I recommend putting this in your `~/.rdebugrc`:

```ruby
set autolist
set autoeval
set autoreload
```

## Recommended reading
* [ruby-debug documentation](http://bashdb.sourceforge.net/ruby-debug.html)
* [RailsCast #54](http://railscasts.com/episodes/54-debugging-with-ruby-debug)
  (the setup steps are out of date, but it shows why ruby-debug can be useful)

## License
MIT License - see `LICENSE.txt`.
