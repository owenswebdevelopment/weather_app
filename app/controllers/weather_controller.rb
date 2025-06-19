require "json"
require "open-uri"

class WeatherController < ApplicationController
  def index
    if params[:city].present?
      @city = params[:city]
      @api_key = ENV["OPENWEATHER_API_KEY"]
      begin
        url = "https://api.openweathermap.org/data/2.5/weather?q=#{URI.encode_www_form_component(@city)}&appid=#{@api_key}&units=metric"
        weather_serialized = URI.open(url).read
        @weather = JSON.parse(weather_serialized)

        if @weather["cod"].to_s != "200"
          flash.now[:alert] = "City not found."
          @weather = nil
        end
      rescue OpenURI::HTTPError => e
        flash.now[:alert] = "There was an error: #{e.message}"
        @weather = nil
      end
    end
  end
end
