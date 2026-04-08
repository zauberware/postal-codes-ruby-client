# frozen_string_literal: true

module PostalCodesRubyClient
  class Configuration
    attr_accessor :base_url, :api_token, :timeout

    def initialize
      @base_url = 'http://localhost:3000'
      @api_token = nil
      @timeout = 30
    end
  end
end
