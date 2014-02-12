require 'date'
require 'net/https'
require 'json'


class WeatherService 

  attr_accessor :forecast
  # Forecast API Key from https://developer.forecast.io
  forecast_api_key = ENV['cfc1a1c2c24fd169125b4f8d1ce3a4e3'] 
   
  # Latitude, Longitude for location
  forecast_location_lat = ENV['39.733536'] 
  forecast_location_long = ENV['-104.992611'] 
   
  # Unit Format
  forecast_units = "ca" # like "si", except windSpeed is in kph
    
  def weather
    http = Net::HTTP.new("api.forecast.io", 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.request(Net::HTTP::Get.new("/forecast/cfc1a1c2c24fd169125b4f8d1ce3a4e3/37.8267,-122.423"))
    forecast = JSON.parse(response.body)
    currently = forecast["currently"]["temperature"]
  end

  def self.todays_weather
    http = Net::HTTP.new("api.forecast.io", 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.request(Net::HTTP::Get.new("/forecast/cfc1a1c2c24fd169125b4f8d1ce3a4e3/37.8267,-122.423"))
    forecast = JSON.parse(response.body)
    forecast
  end

  def self.today
    {
      :summary => todays_weather["daily"]["data"][0]["summary"],
      :high_temp => todays_weather["daily"]["data"][0]["temperatureMax"],
      :low_temp => todays_weather["daily"]["data"][0]["temperatureMin"],
      :chance_of_rain => todays_weather["daily"]["data"][0]["precipProbability"],
      :dew_point => todays_weather["daily"]["data"][0]["dewPoint"] 
    }
  end

end
