class Api::V1::SessionsController < ApplicationController
  include ApipieDefinitions

  api :POST, "/sessions", "Create a new session for user (get authentication token)"
  error 422, "Unable to create new session due to invalid email or password"
  param_group :session
  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user.valid_password? user_password
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  api :DELETE, "/sessions/:id", "Delete a session by authentication token"
  param :id, String, :desc => "The authentication token being invalidated", :required => true
  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end

  private

    resource_description do
      formats ['json']
    end
end
