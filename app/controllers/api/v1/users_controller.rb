class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    respond_with User.find_by_id(params[:id])
  end
end
