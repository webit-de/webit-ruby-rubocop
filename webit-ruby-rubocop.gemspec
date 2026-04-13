# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name        = "webit-ruby-rubocop"
  spec.version     = "3.1.16"
  spec.authors     = ["Roland Schwarzer", "Martin Schrader"]
  spec.email       = ["schwarzer@webit.de"]

  spec.summary     = "webit! specific rubocop configurations"
  spec.description = "This gem provides webit! specific rubocop configurations."
  spec.homepage    = "https://github.com/webit-de/webit-ruby-rubocop"
  spec.license     = "MIT"

  spec.files       = Dir["cops/**/*", "lib/**/*", "config.yml", "README.md", "LICENSE"]

  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  spec.add_dependency "rubocop", ">= 1.84.0"
  spec.add_dependency "rubocop-capybara", ">= 2.22.0"
  spec.add_dependency "rubocop-minitest", ">= 0.35.0"
  spec.add_dependency "rubocop-rake", ">= 0.5.1"
end
