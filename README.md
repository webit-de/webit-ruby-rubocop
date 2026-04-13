# webit-ruby-rubocop

This gem provides webit! specific rubocop configurations. The current webit! code conventions can be found here: see https://github.com/webit-de/webit-ruby-styleguide.

If you are looking for Rails specific configuration, check out [webit-rails-rubocop](https://github.com/webit-de/webit-rails-rubocop).

## Installation

Add the following line to your Gemfile:

```ruby
gem "webit-ruby-rubocop"
```

In your own project, add a `.rubocop.yml` containing this configuration:

```yml
inherit_gem:
  webit-ruby-rubocop: config.yml
```

## Usage

```bash
$ bundle exec rubocop
```
