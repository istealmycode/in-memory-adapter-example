# frozen_string_literal: true

class WeatherController < ApplicationController
  def index
    location = params[:location]
    return unless location

    @weather = WeatherClient.new.get_current_weather(location:)
    return if @weather&.valid?

    flash.now[:alert] = 'Weather for the location not found.'
  end
end
