if Rails.env.development?
  module DecisionsControllerDoc extend Apipie::DSL::Concern

    def_param_group :decision do
      param :decision, Hash, :action_aware => true, :required => true do
        param :meal, ["Breakfast", "Lunch", "Dinner", "Snack"], :required => true, :desc => "Meal selection"
        param :location, String, :required => true, :desc => "Location of meal (i.e. restaurant)"
        param :participant_id, Integer, :required => true, :desc => "Participant ID of the person making the decision"
      end
    end

    api :GET, "/comparisons/:id/decisions/", "Get all decisions information for a comparison"
    header "Authorization", "Session authentication token for the user", :required => true
    error 401, "Unauthorized"
    example '[{
  "id": 1,
  "meal": "Lunch",
  "location": "McDonald\'s",
  "participant_id": 5,
  "comparison_id": 3,
},
{
  "id": 2,
  "meal": "Dinner",
  "location": "Chili\'s",
  "participant_id": 5,
  "comparison_id": 3,
}
}]'
    def index
      # Stub
    end

    api :GET, "/comparisons/:comparison_id/decisions/:id", "Get a decision information for a comparison by ID"
    header "Authorization", "Session authentication token for the user", :required => true
    param :comparison_id, :number, :desc => "Comparison ID"
    param :id, :number, :desc => "Decision ID", :required => true
    error 401, "Unauthorized"
    error 404, "Decision does not exist"
    example '{
    "id": 1,
    "meal": "Lunch",
    "location": "McDonald\'s",
    "participant_id": 5,
    "comparison_id": 3,
}'
    def show
      # Stub
    end

    api :POST, "/comparisons/:comparison_id/decisions", "Create a new decision for a comparison"
    header "Authorization", "Session authentication token for the user", :required => true
    param :comparison_id, :number, :desc => "Comparison ID"
    param_group :decision
    error 401, "Unauthorized"
    error 422, "Unable to create the decision (probably due to validation issues)"
    def create
      # Stub
    end

    api :PATCH, "/comparisons/:comparison_id/decisions/:id", "Update an existing decision for a comparison"
    header "Authorization", "Session authentication token for the user", :required => true
    param :comparison_id, :number, :desc => "Comparison ID"
    param_group :decision
    error 401, "Unauthorized"
    error 422, "Unable to update the decision (probably due to validation issues)"
    def update
      # Stub
    end

    api :DELETE, "/comparisons/:comparison_id/decisions/:id", "Delete an existing decision for a comparison"
    header "Authorization", "Session authentication token for the user", :required => true
    param :comparison_id, :number, :desc => "Comparison ID"
    param :id, :number, :desc => "Decision ID", :required => true
    error 401, "Unauthorized"
    def destroy
      # Stub
    end
  end
else
  module DecisionsControllerDoc
  end
end
