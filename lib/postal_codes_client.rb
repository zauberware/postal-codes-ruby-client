# frozen_string_literal: true

require_relative "postal_codes_client/version"
require_relative "postal_codes_client/configuration"
require_relative "postal_codes_client/errors"
require_relative "postal_codes_client/resources/postal_codes"
require_relative "postal_codes_client/client"

module PostalCodesClient
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
