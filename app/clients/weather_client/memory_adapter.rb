# frozen_string_literal: true

class WeatherClient
  class MemoryAdapter
    include Singleton
    include Repository
    attr_accessor :repository

    class << self
      delegate_missing_to :instance
    end

    def initialize
      @repository = REPOSITORY.deep_dup
    end

    def get(url)
      return forbidden_response if ENV['WEATHER_API_KEY'] != 'valid-key'

      url = URI.parse(url)
      query_params = CGI.parse(url.query)

      location = query_params['q']&.first
      response_body = @repository.dig(location, :body)
      response_status = @repository.dig(location, :status)
      return Struct.new(:body, :status).new(response_body.to_json, response_status) if response_body

      not_found_response
    end

    private

    def forbidden_response
      error_response = {
        error: {
          code: 403,
          message: 'An unexpected error occurred on the server.'
        }
      }.to_json
      Struct.new(:body, :status).new(error_response, 403)
    end

    def not_found_response
      error_response = {
        error: {
          code: 1006,
          message: 'No matching location found.'
        }
      }.to_json
      Struct.new(:body, :status).new(error_response, 400)
    end
  end
end
