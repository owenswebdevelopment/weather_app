require "json"
require "open-uri"

class WeatherController < ApplicationController
  def index
  end

  def show
    @city = params.dig(:weather, :city)
    @api_key = ENV["OPENWEATHER_API_KEY"]
    url = "https://api.openweathermap.org/data/2.5/weather?q=#{@city}&appid=#{@api_key}&units=metric"

    begin
      weather_serialized = URI.open(url).read
      @weather = JSON.parse(weather_serialized)

      if @weather["cod"].to_s != "200"
        flash[:alert] = "Sorry, we couldn't find the weather for that city."
        render :index and return
      end

      render :show
    rescue OpenURI::HTTPError => e
      flash[:alert] = "There was an error fetching the weather: #{e.message}"
      render :index
    end
  end
end
# fetcher = WeatherFetcher.new(@city)
# @weather = fetcher.call
