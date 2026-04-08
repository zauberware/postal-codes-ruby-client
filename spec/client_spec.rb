# frozen_string_literal: true

require "spec_helper"

RSpec.describe PostalCodesClient::Client do
  let(:base_url) { "http://localhost:3000" }
  let(:token)    { "test_api_token_123" }
  let(:client)   { described_class.new(api_token: token, base_url: base_url) }

  describe "#get" do
    it "sends Authorization header" do
      stub = stub_request(:get, "#{base_url}/api/v1/auth/me")
        .with(headers: { "Authorization" => "Bearer #{token}" })
        .to_return(status: 200, body: '{"user":{"id":1}}', headers: { "Content-Type" => "application/json" })

      client.get("/api/v1/auth/me")
      expect(stub).to have_been_requested
    end
  end

  describe "#post" do
    it "sends JSON body" do
      stub = stub_request(:post, "#{base_url}/api/v1/auth/login")
        .with(
          body: '{"email":"a@b.com","password":"secret"}',
          headers: { "Content-Type" => "application/json" }
        )
        .to_return(status: 200, body: '{"api_token":"new_token"}', headers: { "Content-Type" => "application/json" })

      client.post("/api/v1/auth/login", { email: "a@b.com", password: "secret" })
      expect(stub).to have_been_requested
    end
  end

  describe "error handling" do
    it "raises AuthenticationError on 401" do
      stub_request(:get, "#{base_url}/api/v1/auth/me")
        .to_return(status: 401, body: '{"error":"Unauthorized"}', headers: { "Content-Type" => "application/json" })

      expect { client.get("/api/v1/auth/me") }.to raise_error(PostalCodesClient::AuthenticationError, "Unauthorized")
    end

    it "raises ValidationError on 422" do
      stub_request(:post, "#{base_url}/api/v1/auth/signup")
        .to_return(
          status: 422,
          body: '{"errors":["Email has already been taken"]}',
          headers: { "Content-Type" => "application/json" }
        )

      expect { client.post("/api/v1/auth/signup", {}) }.to raise_error(PostalCodesClient::ValidationError) do |e|
        expect(e.errors).to include("Email has already been taken")
      end
    end

    it "raises ApiError on other error codes" do
      stub_request(:get, "#{base_url}/api/v1/postal_codes?q=test")
        .to_return(status: 500, body: '{"error":"Internal Server Error"}', headers: { "Content-Type" => "application/json" })

      expect { client.get("/api/v1/postal_codes", q: "test") }.to raise_error(PostalCodesClient::ApiError) do |e|
        expect(e.status).to eq(500)
      end
    end
  end
end
