class Api::V1::ParticipantsController < ApplicationController
  respond_to :json

  def index
    # Returns all participants under the comparison id
    respond_with Comparison.find(params[:comparison_id]).participants
  end
end
