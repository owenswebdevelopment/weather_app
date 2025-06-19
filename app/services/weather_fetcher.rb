require "httparty"
require "json"
require "open-uri"

class WeatherFetcher
  include HTTParty
  base_uri 'https://api.openweathermap.org'

  def initialize(city)
    @city = city
    @api_key = ENV["OPENWEATHER_API_KEY"]
    puts ENV["OPENWEATHER_API_KEY"]
  end

  def call
    coords = fetch_coordinates
    return nil unless coords

    fetch_weather(coords[:lat], coords[:lon])

    puts "calling fetcher..."
    puts "Coordinates: #{coords.inspect}"
  end


  private

  def fetch_coordinates
    response = self.class.get("/geo/1.0/direct", query: {
      q: @city,
      limit: 1,
      appid: @api_key
    })

    return nil unless response.code == 200 && response.parsed_response.any?

    {
      lat: response.parsed_response[0]["lat"],
      lon: response.parsed_response[0]["lon"]
    }
  end

  def fetch_weather(lat, lon)
    response = self.class.get("/data/3.0/onecall", query: {
      lat: lat,
      lon: lon,
      exclude: "minutely",
      units: "metric",
      appid: @api_key
    })

    return nil unless response.code == 200

    response.parsed_response

    puts "Weather API response: #{response.parsed_response}"

  end
end
