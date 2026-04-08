# frozen_string_literal: true

require "spec_helper"

RSpec.describe PostalCodesClient::Resources::Auth do
  let(:base_url) { "http://localhost:3000" }
  let(:token)    { "test_token" }
  let(:client)   { PostalCodesClient::Client.new(api_token: token, base_url: base_url) }
  let(:json_headers) { { "Content-Type" => "application/json" } }

  describe "#signup" do
    it "creates a new user" do
      response_body = {
        message: "Account created",
        user: { id: 1, email: "new@example.com", name: "Test", created_at: "2026-01-01" },
        api_token: "new_token"
      }.to_json

      stub_request(:post, "#{base_url}/api/v1/auth/signup")
        .with(body: hash_including(email: "new@example.com"))
        .to_return(status: 201, body: response_body, headers: json_headers)

      result = client.auth.signup(
        email: "new@example.com",
        password: "password123",
        password_confirmation: "password123",
        name: "Test"
      )

      expect(result[:api_token]).to eq("new_token")
      expect(result[:user][:email]).to eq("new@example.com")
    end
  end

  describe "#login" do
    it "returns api_token" do
      response_body = {
        message: "Login successful",
        user: { id: 1, email: "admin@example.com", name: "Admin", created_at: "2026-01-01" },
        api_token: "login_token"
      }.to_json

      stub_request(:post, "#{base_url}/api/v1/auth/login")
        .to_return(status: 200, body: response_body, headers: json_headers)

      result = client.auth.login(email: "admin@example.com", password: "password123")
      expect(result[:api_token]).to eq("login_token")
    end
  end

  describe "#me" do
    it "returns the current user" do
      response_body = {
        user: { id: 1, email: "admin@example.com", name: "Admin", created_at: "2026-01-01" }
      }.to_json

      stub_request(:get, "#{base_url}/api/v1/auth/me")
        .to_return(status: 200, body: response_body, headers: json_headers)

      result = client.auth.me
      expect(result[:user][:email]).to eq("admin@example.com")
    end
  end

  describe "#regenerate_token" do
    it "returns a new token" do
      response_body = { message: "Token regenerated", api_token: "fresh_token" }.to_json

      stub_request(:post, "#{base_url}/api/v1/auth/regenerate_token")
        .to_return(status: 200, body: response_body, headers: json_headers)

      result = client.auth.regenerate_token
      expect(result[:api_token]).to eq("fresh_token")
    end
  end
end
