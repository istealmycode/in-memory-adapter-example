# frozen_string_literal: true

class WeatherController < ApplicationController
  def index; end

  def search
    location = params[:location]

    if location.present?
      @weather = WeatherClient.new.get_current_weather(location:)
    else
      flash[:alert] = 'Please enter a location.'
      redirect_to weather_path
    end
  end
end
