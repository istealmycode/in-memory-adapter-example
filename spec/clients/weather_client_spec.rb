# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherClient do
  let(:weather_client) { WeatherClient.new }

  describe '#get_current_weather' do
    let(:location) { '10001' }
    let(:weather) { weather_client.get_current_weather(location:) }
    let(:tempature) { WeatherClient::MemoryAdapter.repository[location][:body][:current][:temp_c] }

    context 'when requesting a location present in the repository' do
      it 'returns a Weather instance' do
        expect(weather).to be_instance_of(Weather)
      end

      it 'has a tempature' do
        expect(weather.current.temp_c).to eq(tempature)
      end
    end

    context 'when requesting an invalid location' do
      let(:invalid_location) { 'invalid_location' }
      let(:weather) { weather_client.get_current_weather(location: invalid_location) }

      it 'returns a Weather instance' do
        expect(weather).to be_instance_of(Weather)
      end

      it 'the Weather instance is invalid' do
        expect(weather.valid?).to be false
      end

      it 'has an error message' do
        expect(weather.errors.messages[:base]).to include('Failed to retrieve current weather data -- HTTP status: 400')
      end
    end

    context 'when using an invalid API key' do
      before do
        allow(ENV).to receive(:[]).with('WEATHER_API_KEY').and_return(nil)
      end

      let(:weather) { weather_client.get_current_weather(location:) }

      it 'returns a Weather instance' do
        expect(weather).to be_instance_of(Weather)
      end

      it 'the Weather instance is invalid' do
        expect(weather.valid?).to be false
      end

      it 'has an error message for the invalid API key' do
        expect(weather.errors.messages[:base]).to include('Failed to retrieve current weather data -- HTTP status: 403')
      end
    end
  end
end
