# frozen_string_literal: true

class WeatherClient
  module Repository
    def self.generate_location_data(name, region, country, lat, lon, tz_id)
      {
        name:,
        region:,
        country:,
        lat:,
        lon:,
        tz_id:,
        localtime_epoch: Time.now.to_i,
        localtime: Time.now.strftime('%Y-%m-%d %H:%M')
      }
    end

    def self.generate_current_weather_data
      {
        last_updated_epoch: Time.now.to_i,
        last_updated: Time.now.strftime('%Y-%m-%d %H:%M'),
        temp_c: Faker::Number.decimal(l_digits: 2, r_digits: 1),
        temp_f: Faker::Number.decimal(l_digits: 2, r_digits: 1),
        is_day: Faker::Number.between(from: 0, to: 1),
        condition: {
          text: Faker::Lorem.sentence,
          icon: Faker::Internet.url,
          code: Faker::Number.between(from: 1000, to: 2000)
        },
        wind_mph: Faker::Number.decimal(l_digits: 2, r_digits: 1),
        wind_kph: Faker::Number.decimal(l_digits: 2, r_digits: 1),
        wind_degree: Faker::Number.between(from: 0, to: 360),
        wind_dir: Faker::Compass.abbreviation,
        pressure_mb: Faker::Number.between(from: 1000, to: 1030),
        pressure_in: Faker::Number.decimal(l_digits: 2, r_digits: 2),
        precip_mm: Faker::Number.decimal(l_digits: 2, r_digits: 2),
        precip_in: Faker::Number.decimal(l_digits: 2, r_digits: 2),
        humidity: Faker::Number.between(from: 0, to: 100),
        cloud: Faker::Number.between(from: 0, to: 100),
        feelslike_c: Faker::Number.decimal(l_digits: 2, r_digits: 1),
        feelslike_f: Faker::Number.decimal(l_digits: 2, r_digits: 1),
        vis_km: Faker::Number.between(from: 0, to: 20),
        vis_miles: Faker::Number.between(from: 0, to: 12),
        uv: Faker::Number.between(from: 0, to: 12),
        gust_mph: Faker::Number.decimal(l_digits: 2, r_digits: 1),
        gust_kph: Faker::Number.decimal(l_digits: 2, r_digits: 1),
        air_quality: {
          co: Faker::Number.decimal(l_digits: 3, r_digits: 1),
          no2: Faker::Number.decimal(l_digits: 2, r_digits: 1),
          o3: Faker::Number.decimal(l_digits: 3, r_digits: 1),
          so2: Faker::Number.decimal(l_digits: 2, r_digits: 1),
          pm2_5: Faker::Number.decimal(l_digits: 2, r_digits: 1),
          pm10: Faker::Number.decimal(l_digits: 2, r_digits: 1),
          'us-epa-index': Faker::Number.between(from: 0, to: 5),
          'gb-defra-index': Faker::Number.between(from: 0, to: 5)
        }
      }
    end

    REPOSITORY = {
      '10001': {
        body: {
          location: generate_location_data('New York', 'New York', 'United States of America', 40.713, -74.00,
                                           'America/Phoenix'),
          current: generate_current_weather_data
        },
        status: 200
      },
      '85001': {
        body: {
          location: generate_location_data('Phoenix', 'Arizona', 'United States of America', 33.45, -112.07,
                                           'America/Phoenix'),
          current: generate_current_weather_data
        },
        status: 200
      },
      '68101': {
        body: {
          location: generate_location_data('Omaha', 'Nebraska', 'United States of America', 41.26, -95.94,
                                           'America/Chicago'),
          current: generate_current_weather_data
        },
        status: 200
      },
      ERROR_LOCATION: {
        body: {
          error: {
            code: 500,
            message: 'Internal Server Error',
            details: 'An unexpected error occurred on the server.'
          }
        },
        status: 500
      }
    }.with_indifferent_access
  end
end
