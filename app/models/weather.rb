# frozen_string_literal: true

require 'active_model'

class Weather
  include ActiveModel::Model

  attr_accessor :location, :current, :condition, :air_quality

  def initialize(attributes = {})
    @location = Location.new attributes[:location]
    @current = CurrentWeather.new attributes[:current]
    @condition = Condition.new attributes.dig(:current, :condition)
  end

  def valid?
    errors.empty?
  end
end
