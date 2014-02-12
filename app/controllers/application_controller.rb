class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    response = Faraday.get("api/v1/users/#{cookies[:user_id]}")
    @current_user ||= JSON.parse(response)
  end

  def host
    Rails.env.production? ? prod_url : dev_url
  end

  private

  def prod_url
    "http://107.170.7.85"
  end

  def dev_url
    "http://localhost:8080"
  end

end
