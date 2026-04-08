# frozen_string_literal: true

require 'postal_codes_ruby_client'
require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:each) do
    PostalCodesRubyClient.reset!
  end
end
