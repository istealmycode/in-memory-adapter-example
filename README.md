# WeatherApp

WeatherApp is a simple Rails application that fetches weather information from weatherapi.com. The purpose of this code is show how an api client which has both in memory and http adapters can be used for local development and to run tests against without using tools like webmock or vcr. 

By default, the in memory adapter will be used. To use the http adapter setup your .env file to set  your WEATHER_API_KEY and set WEATHER_API_CLIENT=WeatherClient::HttpAdapter

## Getting Started

### Prerequisites

Make sure you have the following installed:

- Ruby
- Rails

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/istealmycode/in-memory-adapter-example.git
   ```
2. Install dependencies:

    ```
    cd weather-app
    bundle install
    ```

### Usage
1. Run the rails server

    ```bash
    bundle exec rails server
    ```
2. Connect to the server at http://127.0.0.1:3000

### Tests

1. Run rspec

    ```bash
    bundle exec rspec
    ```


