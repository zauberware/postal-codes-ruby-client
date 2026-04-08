# frozen_string_literal: true

module PostalCodesRubyClient
  module Resources
    class PostalCodes
      def initialize(client)
        @client = client
      end

      # Search for postal codes.
      #
      # @param q [String] Full or partial postal code (required)
      # @param country [String, nil] ISO country code, e.g. "DE", "AT", "CH"
      # @param limit [Integer, nil] Max results (default 50, max 200)
      # @return [Hash] { query:, country:, count:, results: [...] }
      def search(q:, country: nil, limit: nil)
        params = { q: q }
        params[:country] = country if country
        params[:limit] = limit if limit
        @client.get('/api/v1/postal_codes', params)
      end

      # List all available country codes.
      #
      # @return [Hash] { countries: ["AT", "CH", "DE", ...] }
      def countries
        @client.get('/api/v1/postal_codes/countries')
      end
    end
  end
end
