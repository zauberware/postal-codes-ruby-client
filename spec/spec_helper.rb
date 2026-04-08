# frozen_string_literal: true

require "postal_codes_client"
require "webmock/rspec"

RSpec.configure do |config|
  config.before(:each) do
    PostalCodesClient.reset!
  end
end
