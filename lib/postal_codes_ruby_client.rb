# frozen_string_literal: true

require_relative 'postal_codes_ruby_client/version'
require_relative 'postal_codes_ruby_client/configuration'
require_relative 'postal_codes_ruby_client/errors'
require_relative 'postal_codes_ruby_client/resources/postal_codes'
require_relative 'postal_codes_ruby_client/client'

module PostalCodesRubyClient
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset!
      @configuration = Configuration.new
    end
  end
end
