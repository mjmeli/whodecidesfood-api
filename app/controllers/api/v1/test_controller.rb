class Api::V1::TestController < ApplicationController
  def index
    render json:
    {
      "message": "You're connected!",
      "authenticated": user_signed_in?
    }, status: 200
  end
end
