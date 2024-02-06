# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Weather', type: :request do
  describe 'GET /weather' do
    before do
      get weather_path
    end

    it 'returns a 200 response' do
      expect(response).to have_http_status(200)
    end

    it 'has a search form' do
      expect(response.body).to include('form')
    end
  end

  describe 'GET /weather/search' do
    let(:tempature) { WeatherClient::MemoryAdapter.repository['10001'][:body][:current][:temp_f] }

    it 'redirects without a location' do
      get weather_search_path
      expect(response).to redirect_to(weather_path)
    end

    context 'with a valid location' do
      before do
        get weather_search_path params: { location: '10001' }
      end

      it 'displays the city' do
        expect(response.body).to include('New York')
      end

      it 'displays the tepature' do
        expect(response.body).to include("Temperature: #{tempature}°F")
      end
    end
  end
end
