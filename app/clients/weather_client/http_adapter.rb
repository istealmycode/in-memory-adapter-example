# frozen_string_literal: true

class WeatherClient
  class HttpAdapter
    class << self
      delegate_missing_to Faraday
    end
  end
end
