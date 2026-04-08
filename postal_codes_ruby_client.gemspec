# frozen_string_literal: true

require_relative "lib/postal_codes_ruby_client/version"

Gem::Specification.new do |spec|
  spec.name    = "postal_codes_ruby_client"
  spec.version = PostalCodesRubyClient::VERSION
  spec.authors = ["zauberware technologies"]
  spec.summary = "Ruby client for the PLZ (Postleitzahlen) API"
  spec.description = "A Ruby gem to search postal codes across 100+ countries via the PLZ API. " \
                     "Supports authentication, postal code search, and country listing."
  spec.homepage = "https://github.com/zauberware/postal-codes-ruby-client"
  spec.license  = "MIT"
  spec.required_ruby_version = ">= 3.1"

  spec.files = Dir["lib/**/*.rb", "README.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.0"
end
