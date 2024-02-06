# frozen_string_literal: true

class CurrentWeather
  include ActiveModel::Model

  attr_accessor :last_updated_epoch, :last_updated, :temp_c, :temp_f, :is_day, :wind_mph, :wind_kph,
                :wind_degree, :wind_dir, :pressure_mb, :pressure_in, :precip_mm, :precip_in, :humidity,
                :cloud, :feelslike_c, :feelslike_f, :vis_km, :vis_miles, :uv, :gust_mph, :gust_kph,
                :condition, :air_quality
end
