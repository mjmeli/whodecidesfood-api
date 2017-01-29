class Api::V1::ParticipantsController < ApplicationController
  respond_to :json

  def index
    # Returns all participants under the comparison id
    respond_with current_comparison.participants
  end

  def show
    respond_with current_comparison.participants.find(params[:id])
  end

  def create
    participant = current_comparison.participants.build(participant_params)
    if participant.save
      render json: participant, status: 201, location: [:api, current_comparison, participant]
    else
      render json: { errors: participant.errors }, status: 422
    end
  end

  def update
    participant = current_comparison.participants.find(params[:id])
    if participant.update(participant_params)
      render json: participant, status: 200, location: [:api, current_comparison, participant]
    else
      render json: { errors: participant.errors }, status: 422
    end
  end

  def destroy
    participant = current_comparison.participants.find(params[:id])
    participant.destroy
    head 204
  end

  private

    def current_comparison
      @current_comparison ||= Comparison.find(params[:comparison_id])
    end

    def participant_params
      params.require(:participant).permit(:name, :comparison_id)
    end
end
