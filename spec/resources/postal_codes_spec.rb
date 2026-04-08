# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PostalCodesRubyClient::Resources::PostalCodes do
  let(:base_url) { 'http://localhost:3000' }
  let(:token)    { 'test_token' }
  let(:client)   { PostalCodesRubyClient::Client.new(api_token: token, base_url: base_url) }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }

  describe '#search' do
    it 'searches by postal code' do
      response_body = {
        query: '803',
        country: 'DE',
        count: 2,
        results: [
          { zipcode: '80331', place: 'München', state: 'Bayern', country_code: 'DE',
            community: 'München', latitude: 48.1374, longitude: 11.5755 },
          { zipcode: '80333', place: 'München', state: 'Bayern', country_code: 'DE',
            community: 'München', latitude: 48.1447, longitude: 11.5688 }
        ]
      }.to_json

      stub_request(:get, "#{base_url}/api/v1/postal_codes")
        .with(query: { q: '803', country: 'DE' })
        .to_return(status: 200, body: response_body, headers: json_headers)

      result = client.postal_codes.search(q: '803', country: 'DE')
      expect(result[:count]).to eq(2)
      expect(result[:results].first[:place]).to eq('München')
    end

    it 'searches without country filter' do
      response_body = { query: '1010', country: nil, count: 1, results: [] }.to_json

      stub_request(:get, "#{base_url}/api/v1/postal_codes")
        .with(query: { q: '1010' })
        .to_return(status: 200, body: response_body, headers: json_headers)

      result = client.postal_codes.search(q: '1010')
      expect(result[:query]).to eq('1010')
    end

    it 'supports limit parameter' do
      stub_request(:get, "#{base_url}/api/v1/postal_codes")
        .with(query: { q: '10', limit: '5' })
        .to_return(status: 200, body: '{"query":"10","count":0,"results":[]}', headers: json_headers)

      result = client.postal_codes.search(q: '10', limit: 5)
      expect(result[:count]).to eq(0)
    end

    it 'raises ValidationError when q is missing' do
      stub_request(:get, "#{base_url}/api/v1/postal_codes")
        .with(query: { q: '' })
        .to_return(
          status: 422,
          body: '{"error":"Parameter \'q\' is required (full or partial postal code)"}',
          headers: json_headers
        )

      expect { client.postal_codes.search(q: '') }.to raise_error(PostalCodesRubyClient::ValidationError)
    end
  end

  describe '#countries' do
    it 'lists available countries' do
      response_body = { countries: %w[AT CH DE FR US] }.to_json

      stub_request(:get, "#{base_url}/api/v1/postal_codes/countries")
        .to_return(status: 200, body: response_body, headers: json_headers)

      result = client.postal_codes.countries
      expect(result[:countries]).to include('DE', 'AT', 'CH')
    end
  end
end
