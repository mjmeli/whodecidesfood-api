class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :update, :destroy]
  before_action :authenticate_with_token!, only: [:show], if_not: :admin_signed_in?
  respond_to :json

  include ApipieDefinitions

  api :GET, "/users", "Get user information for current user"
  header "Authorization", "Session authentication token for the user", :required => true
  def index
    # Return the current user unless admin access
    if admin_signed_in?
      respond_with User.all
    else
      respond_with current_user unless authenticate_with_token!
    end
  end

  api :GET, "/users/:id", "Get user information by ID"
  header "Authorization", "Session authentication token for the user", :required => true
  param :id, :number, :desc => "User ID", :required => true
  error 401, "Trying to access a different user than authorized"
  def show
    # When no admin access, only show the user if the ids match
    if admin_signed_in? || current_user_matches_id?(params[:id])
      respond_with User.find_by_id(params[:id])
    else
      render json: { errors: "Not authorized" }, status: :unauthorized
    end
  end

  api :POST, "/users", "Create a new user"
  param_group :user
  error 422, "Unable to create the user (probably due to validation issues)"
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  api :PATCH, "/users/:id", "Update an existing user"
  header "Authorization", "Session authentication token for the user", :required => true
  param_group :user
  error 422, "Unable to update the user (probably due to validation issues)"
  def update
    user = current_user
    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  api :DELETE, "/users/:id", "Delete an existing user"
  header "Authorization", "Session authentication token for the user", :required => true
  param :id, :number, :desc => "User ID", :required => true
  def destroy
    current_user.destroy
    head 204
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def current_user_matches_id?(id)
      current_user.present? && current_user.id == params[:id].to_i
    end

    resource_description do
      formats ['json']
    end
end
