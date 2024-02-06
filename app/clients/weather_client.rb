# frozen_string_literal: true

class WeatherClient
  def initialize
    @adapter = ENV.fetch('WEATHER_API_CLIENT', 'WeatherClient::MemoryAdapter').constantize
  end

  def get_current_weather(location:)
    response = @adapter.get(current_weather_url(location:))

    return weather_with_errors(response.status) unless response.status == 200

    Weather.new(JSON(response.body, symbolize_names: true).deep_transform_keys do |key|
                  key.to_s.underscore
                end.with_indifferent_access)
  end

  private

  def weather_with_errors(status)
    weather = Weather.new
    weather.errors.add(:base,
                       "Failed to retrieve current weather data -- HTTP status: #{status}")
    weather
  end

  def current_weather_url(location:)
    "https://api.weatherapi.com/v1/current.json?key=#{ENV.fetch('WEATHER_API_KEY', nil)}&q=#{location}&aqi=no"
  end
end
