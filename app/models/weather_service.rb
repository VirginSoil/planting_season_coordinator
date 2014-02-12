require 'date'
require 'net/https'
require 'json'


class WeatherService 

  attr_accessor :forecast
  # Forecast API Key from https://developer.forecast.io
  forecast_api_key = ENV['cfc1a1c2c24fd169125b4f8d1ce3a4e3'] 

  # Unit Format
  forecast_units = "ca" # like "si", except windSpeed is in kph

  def self.todays_weather(lat, lng)
    http = Net::HTTP.new("api.forecast.io", 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.request(Net::HTTP::Get.new("/forecast/cfc1a1c2c24fd169125b4f8d1ce3a4e3/#{lat},#{lng}"))
    forecast = JSON.parse(response.body)
    forecast
  end

  def self.today(lat, lng)
    weather = todays_weather(lat, lng)["daily"]["data"][0]
    {
      :summary => weather["summary"],
      :high_temp => weather["temperatureMax"],
      :low_temp => weather["temperatureMin"],
      :chance_of_rain => weather["precipProbability"],
      :dew_point => weather["dewPoint"],
      :humidity =>  weather["humidity"]
    }
  end

end
