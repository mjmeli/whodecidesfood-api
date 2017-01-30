class Api::V1::ParticipantsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  include ApipieDefinitions

  api :GET, "/comparisons/:id/participants/", "Get all participants information for a comparison"
  header "Authorization", "Session authentication token for the user", :required => true
  def index
    # Returns all participants under the comparison id
    respond_with current_comparison.participants
  end

  api :GET, "/comparisons/:comparison_id/participants/:id", "Get a participant information for a comparison by ID"
  header "Authorization", "Session authentication token for the user", :required => true
  param :comparison_id, :number, :desc => "Comparison ID"
  param :id, :number, :desc => "Participant ID", :required => true
  error 404, "Trying to access a participant that you don't have access to"
  def show
    respond_with current_comparison.participants.find(params[:id])
  end

  api :POST, "/comparisons/:comparison_id/participants", "Create a new participant for a comparison"
  param :comparison_id, :number, :desc => "Comparison ID"
  param_group :participant
  error 422, "Unable to create the participant (probably due to validation issues)"
  def create
    participant = current_comparison.participants.build(participant_params)
    if participant.save
      render json: participant, status: 201, location: [:api, current_comparison, participant]
    else
      render json: { errors: participant.errors }, status: 422
    end
  end

  api :PATCH, "/comparisons/:comparison_id/participants/:id", "Update an existing participant for a comparison"
  header "Authorization", "Session authentication token for the user", :required => true
  param :comparison_id, :number, :desc => "Comparison ID"
  param_group :participant
  error 422, "Unable to update the participant (probably due to validation issues)"
  def update
    participant = current_comparison.participants.find(params[:id])
    if participant.update(participant_params)
      render json: participant, status: 200, location: [:api, current_comparison, participant]
    else
      render json: { errors: participant.errors }, status: 422
    end
  end

  api :DELETE, "/comparisons/:comparison_id/participants/:id", "Delete an existing participant for a comparison"
  header "Authorization", "Session authentication token for the user", :required => true
  param :comparison_id, :number, :desc => "Comparison ID"
  param :id, :number, :desc => "User ID", :required => true
  def destroy
    participant = current_comparison.participants.find(params[:id])
    participant.destroy
    head 204
  end

  private

    def current_comparison
      @current_comparison ||= current_user.comparisons.find(params[:comparison_id])
    end

    def participant_params
      params.require(:participant).permit(:name, :comparison_id)
    end
end
