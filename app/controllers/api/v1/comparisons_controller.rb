class Api::V1::ComparisonsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  include ApipieDefinitions

  api :GET, "/comparisons", "Get all comparisons for the authenticated user"
  header "Authorization", "Session authentication token for the user", :required => true
  def index
    # Return all comparisons for user unless the comparison_ids parameter is sent
    comparisons = params[:comparison_ids].present? ?
                  current_user.comparisons.find(params[:comparison_ids]) :
                  current_user.comparisons.all
    respond_with comparisons
  end

  api :GET, "/comparisons/:id", "Get comparison information by ID"
  header "Authorization", "Session authentication token for the user", :required => true
  param :id, :number, :desc => "Comparison ID", :required => true
  error 404, "Trying to access a comparison that you don't have access to"
  def show
    respond_with current_user.comparisons.find(params[:id])
  end

  api :POST, "/comparisons", "Create a new comparison for the current user"
  header "Authorization", "Session authentication token for the user", :required => true
  param_group :comparison
  error 422, "Unable to create the comparison (probably due to validation issues)"
  def create
    comparison = current_user.comparisons.build(comparison_params)
    if comparison.save
      render json: comparison, status: 201, location: [:api, comparison]
    else
      render json: { errors: comparison.errors }, status: 422
    end
  end

  api :PATCH, "/comparisons/:id", "Update an existing comparison"
  header "Authorization", "Session authentication token for the user", :required => true
  param_group :comparison
  error 422, "Unable to update the comparison (probably due to validation issues)"
  def update
    comparison = current_user.comparisons.find(params[:id])
    if comparison.update(comparison_params)
      render json: comparison, status: 200, location: [:api, comparison]
    else
      render json: { errors: comparison.errors }, status: 422
    end
  end

  api :DELETE, "/comparisons/:id", "Delete an existing comparison"
  header "Authorization", "Session authentication token for the user", :required => true
  param :id, :number, :desc => "Comparison ID", :required => true
  def destroy
    comparison = current_user.comparisons.find(params[:id])
    comparison.destroy
    head 204
  end

  private

    def comparison_params
      params.require(:comparison).permit(:title)
    end

    resource_description do
      formats ['json']
    end
end
