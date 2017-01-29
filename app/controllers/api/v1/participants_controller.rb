class Api::V1::ParticipantsController < ApplicationController
  respond_to :json

  def index
    # Returns all participants under the comparison id
    respond_with current_comparison.participants
  end

  def show
    respond_with current_comparison.participants.find(params[:id])
  end

  private

    def current_comparison
      @current_comparison ||= Comparison.find(params[:comparison_id])
    end
end
