class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    response = Faraday.get("api/v1/users/#{cookies[:user_id]}")
    @current_user ||= JSON.parse(response)
  end

end
