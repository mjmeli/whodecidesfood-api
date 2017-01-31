class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  include Authenticable

  # rescue_from StandardError do |exception|
  #   raise unless request.format.json?
  #   render json: { :error => exception.message }, :status => 500
  # end
  #
  # rescue_from ActiveRecord::RecordNotFound do
  #   render json: { :error => "" }
  # end
end
