# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherClient::MemoryAdapter do
  describe '#get' do
    context 'with a valid location' do
      let(:valid_location_url) { 'https://example.com/api?q=10001' }

      it 'returns a valid response for a valid location' do
        response = described_class.instance.get(valid_location_url)
        expect(response.status).to eq(200)
      end
    end

    context 'with an invalid location' do
      let(:invalid_location_url) { 'https://example.com/api?q=INVALID_LOCATION' }

      it 'returns a not found response for an invalid location' do
        response = described_class.instance.get(invalid_location_url)
        expect(response.status).to eq(400)
        expect(response.body).to include('No matching location found')
      end
    end

    context 'with a server error' do
      let(:error_location_url) { 'https://example.com/api?q=ERROR_LOCATION' }

      it 'returns a not found response for an invalid location' do
        response = described_class.instance.get(error_location_url)
        expect(response.status).to eq(500)
        expect(response.body).to include('An unexpected error occurred on the server.')
      end
    end
  end
end
