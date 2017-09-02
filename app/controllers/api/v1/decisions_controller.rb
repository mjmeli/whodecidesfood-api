class Api::V1::DecisionsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  include DecisionsControllerDoc

  def index
    # Returns all decisions under the comparison id
    respond_with current_comparison.decisions
  end

  def show
    respond_with current_comparison.decisions.find(params[:id])
  end

  def create
    decision = current_comparison.decisions.build(decision_params)
    if decision.save
      render json: decision, status: 201, location: [:api, current_comparison, decision]
    else
      render json: { errors: decision.errors }, status: 422
    end
  end

  def update
    decision = current_comparison.decisions.find(params[:id])
    if decision.update(decision_params)
      render json: decision, status: 200, location: [:api, current_comparison, decision]
    else
      render json: { errors: decision.errors }, status: 422
    end
  end

  def destroy
    decision = current_comparison.decisions.find(params[:id])
    decision.destroy
    head 204
  end

  private

    def current_comparison
      @current_comparison ||= current_user.comparisons.find(params[:comparison_id])
    end

    def decision_params
      params.require(:decision).permit(:meal, :location, :comparison_id, :participant_id)
    end
end
