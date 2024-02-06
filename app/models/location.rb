# frozen_string_literal: true

class Location
  include ActiveModel::Model

  attr_accessor :name, :region, :country, :lat, :lon, :tz_id, :localtime_epoch, :localtime
end
