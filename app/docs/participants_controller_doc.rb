module ParticipantsControllerDoc extend Apipie::DSL::Concern

  def_param_group :participant do
    param :participant, Hash, :action_aware => true, :required => true do
      param :name, String, :required => true, :desc => "Name for the participant"
    end
  end

  api :GET, "/comparisons/:comparison_id/participants/", "Get all participants information for a comparison"
  header "Authorization", "Session authentication token for the user", :required => true
  param :comparison_id, :number, :desc => "Comparison ID", :required => true
  error 401, "Unauthorized"
  example '[{
"id": 1,
"name": "Rosalia Schultz",
"score": 42,
"decision_ids": [1, 2, 3, 4, 5]
}, {
"id": 2,
"name": "Brinda Adams",
"score": 71,
"decision_ids": [4, 5]
}]'
  def index
    # Stub
  end

  api :GET, "/comparisons/:comparison_id/participants/:id", "Get a participant information for a comparison by ID"
  header "Authorization", "Session authentication token for the user", :required => true
  param :comparison_id, :number, :desc => "Comparison ID", :required => true
  param :id, :number, :desc => "Participant ID", :required => true
  error 401, "Unauthorized"
  error 404, "Participant does not exist"
  example '{
"id": 1,
"name": "Rosalia Schultz",
"score": 42,
"decision_ids": [1, 2, 3, 4, 5]
}'
  def show
    # Stub
  end

  api :POST, "/comparisons/:comparison_id/participants", "Create a new participant for a comparison"
  header "Authorization", "Session authentication token for the user", :required => true
  param :comparison_id, :number, :desc => "Comparison ID", :required => true
  param_group :participant
  error 401, "Unauthorized"
  error 422, "Unable to create the participant (probably due to validation issues)"
  def create
    # Stub
  end

  api :PATCH, "/comparisons/:comparison_id/participants/:id", "Update an existing participant for a comparison"
  header "Authorization", "Session authentication token for the user", :required => true
  param :comparison_id, :number, :desc => "Comparison ID", :required => true
  param :id, :number, :desc => "User ID", :required => true
  param_group :participant
  error 401, "Unauthorized"
  error 422, "Unable to update the participant (probably due to validation issues)"
  def update
    # Stub
  end

  api :DELETE, "/comparisons/:comparison_id/participants/:id", "Delete an existing participant for a comparison"
  header "Authorization", "Session authentication token for the user", :required => true
  param :comparison_id, :number, :desc => "Comparison ID"
  param :id, :number, :desc => "User ID", :required => true
  error 401, "Unauthorized"
  def destroy
    # Stub
  end
end
