# frozen_string_literal: true

require "net/http"
require "uri"
require "json"

module PostalCodesRubyClient
  class Client
    attr_reader :postal_codes

    def initialize(api_token: nil, base_url: nil)
      @api_token = api_token || PostalCodesRubyClient.configuration.api_token
      @base_url  = base_url  || PostalCodesRubyClient.configuration.base_url
      @timeout   = PostalCodesRubyClient.configuration.timeout

      @postal_codes = Resources::PostalCodes.new(self)
    end

    # Update the API token (e.g. after login or token regeneration).
    def api_token=(token)
      @api_token = token
    end

    # Perform a GET request.
    def get(path, params = {})
      uri = build_uri(path, params)
      request = Net::HTTP::Get.new(uri)
      execute(uri, request)
    end

    # Perform a POST request with a JSON body.
    def post(path, body = nil)
      uri = build_uri(path)
      request = Net::HTTP::Post.new(uri)
      if body
        request.body = JSON.generate(body)
        request["Content-Type"] = "application/json"
      end
      execute(uri, request)
    end

    private

    def build_uri(path, params = {})
      uri = URI.join(@base_url, path)
      uri.query = URI.encode_www_form(params) unless params.empty?
      uri
    end

    def execute(uri, request)
      request["Authorization"] = "Bearer #{@api_token}" if @api_token
      request["Accept"] = "application/json"

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"
      http.open_timeout = @timeout
      http.read_timeout = @timeout

      response = http.request(request)
      handle_response(response)
    end

    def handle_response(response)
      body = response.body ? JSON.parse(response.body, symbolize_names: true) : nil

      case response.code.to_i
      when 200, 201
        body
      when 401
        raise AuthenticationError, body&.dig(:error) || "Unauthorized"
      when 422
        raise ValidationError.new(
          body&.dig(:error) || "Validation failed",
          errors: body&.dig(:errors) || []
        )
      else
        raise ApiError.new(
          body&.dig(:error) || "API error (HTTP #{response.code})",
          status: response.code.to_i,
          body: body
        )
      end
    end
  end
end
