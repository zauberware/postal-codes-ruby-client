# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PostalCodesRubyClient do
  describe '.configure' do
    it 'stores configuration' do
      described_class.configure do |config|
        config.base_url  = 'https://api.example.com'
        config.api_token = 'test_token'
        config.timeout   = 60
      end

      expect(described_class.configuration.base_url).to eq('https://api.example.com')
      expect(described_class.configuration.api_token).to eq('test_token')
      expect(described_class.configuration.timeout).to eq(60)
    end
  end

  describe '.reset!' do
    it 'resets configuration to defaults' do
      described_class.configure { |c| c.api_token = 'abc' }
      described_class.reset!
      expect(described_class.configuration.api_token).to be_nil
      expect(described_class.configuration.base_url).to eq('http://localhost:3000')
    end
  end
end
