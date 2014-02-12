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
   
  def time_to_str(time_obj)
    """ format: 5 pm """
    return Time.at(time_obj).strftime "%-l %P"
  end
   
  def time_to_str_minutes(time_obj)
    """ format: 5:38 pm """
    return Time.at(time_obj).strftime "%-l:%M %P"
  end
    
  def day_to_str(time_obj)
    """ format: Sun """
    return Time.at(time_obj).strftime "%a"
  end
    
  def weather
    http = Net::HTTP.new("api.forecast.io", 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.request(Net::HTTP::Get.new("/forecast/cfc1a1c2c24fd169125b4f8d1ce3a4e3/37.8267,-122.423"))
    forecast = JSON.parse(response.body)
    currently = forecast["currently"]["temperature"]
  end

  def current
    http = Net::HTTP.new("api.forecast.io", 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.request(Net::HTTP::Get.new("/forecast/cfc1a1c2c24fd169125b4f8d1ce3a4e3/37.8267,-122.423"))
    forecast = JSON.parse(response.body)
    current = {
      temperature: forecast["currently"]["temperature"].round,
      summary: forecast["currently"]["summary"],
      # humidity: "#{(currently["humidity"] * 100).round}&#37;",
      wind_speed: forecast["currently"]["windSpeed"].round,
      wind_bearing: forecast["currently"]["windSpeed"].round == 0 ? 0 : forecast["currently"]["windBearing"],
      # icon: currently["icon"]
    }
    current
  end
  #   daily = forecast["daily"]["data"][0]
  #   today = {
  #     summary: forecast["hourly"]["summary"],
  #     high: daily["temperatureMax"].round,
  #     low: daily["temperatureMin"].round,
  #     sunrise: time_to_str_minutes(daily["sunriseTime"]),
  #     sunset: time_to_str_minutes(daily["sunsetTime"]),
  #     icon: daily["icon"]
  #   }
   
  #   this_week = []
  #   for day in (1..7) 
  #     day = forecast["daily"]["data"][day]
  #     this_day = {
  #       max_temp: day["temperatureMax"].round,
  #       min_temp: day["temperatureMin"].round,
  #       time: day_to_str(day["time"]),
  #       icon: day["icon"]
  #     }
  #     this_week.push(this_day)
  #   end
   
  #   send_event('verbinski', { 
  #     current: current,
  #     today: today,
  #     upcoming_week: this_week,
  #   })
  # end
end
