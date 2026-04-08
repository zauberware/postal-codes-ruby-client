# frozen_string_literal: true

module PostalCodesClient
  class Error < StandardError; end

  class AuthenticationError < Error; end

  class ValidationError < Error
    attr_reader :errors

    def initialize(message, errors: [])
      @errors = errors
      super(message)
    end
  end

  class ApiError < Error
    attr_reader :status, :body

    def initialize(message, status:, body: nil)
      @status = status
      @body = body
      super(message)
    end
  end
end
