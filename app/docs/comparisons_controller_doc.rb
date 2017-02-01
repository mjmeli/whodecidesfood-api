if Rails.env.development?
  module ComparisonsControllerDoc extend Apipie::DSL::Concern

    def_param_group :comparison do
      param :comparison, Hash, :action_aware => true, :required => true do
        param :title, String, :required => true, :desc => "Title for the comparison"
      end
    end

    api :GET, "/comparisons", "Get all comparisons for the authenticated user"
    header "Authorization", "Session authentication token for the user", :required => true
    error 401, "Unauthorized"
    example '[{
  "id": 1,
  "title": "Family and Friends",
  "owner": {
    "id": 1,
    "email": "brinda@boyer.com"
  },
  "decision_ids": [1, 2, 3],
  "participants": [{
    "id": 1,
    "name": "Rosalia Schultz",
    "score": 42,
    "decision_ids": [1, 2, 3, 4, 5]
  }, {
    "id": 2,
    "name": "Brinda Adams",
    "score": 71,
    "decision_ids": [4, 5]
  }]
}]'
    def index
      # Stub
    end

    api :GET, "/comparisons/:id", "Get comparison information by ID"
    header "Authorization", "Session authentication token for the user", :required => true
    param :id, :number, :desc => "Comparison ID", :required => true
    error 401, "Unauthorized"
    error 404, "Comparison does not exist"
    example '{
  "id": 1,
  "title": "Family and Friends",
  "owner": {
    "id": 1,
    "email": "brinda@boyer.com"
  },
  "decision_ids": [1, 2, 3],
  "participants": [{
    "id": 1,
    "name": "Rosalia Schultz",
    "score": 42,
    "decision_ids": [1, 2, 3, 4, 5]
  }, {
    "id": 2,
    "name": "Brinda Adams",
    "score": 71,
    "decision_ids": [4, 5]
  }]
}'
    def show
      # Stub
    end

    api :POST, "/comparisons", "Create a new comparison for the current user"
    header "Authorization", "Session authentication token for the user", :required => true
    param_group :comparison
    error 401, "Unauthorized"
    error 422, "Unable to create the comparison (probably due to validation issues)"
    def create
      # Stub
    end

    api :PATCH, "/comparisons/:id", "Update an existing comparison"
    header "Authorization", "Session authentication token for the user", :required => true
    param_group :comparison
    error 401, "Unauthorized"
    error 422, "Unable to update the comparison (probably due to validation issues)"
    def update
      # Stub
    end

    api :DELETE, "/comparisons/:id", "Delete an existing comparison"
    header "Authorization", "Session authentication token for the user", :required => true
    param :id, :number, :desc => "Comparison ID", :required => true
    error 401, "Unauthorized"
    def destroy
      # Stub
    end
  end
else
  module ComparisonsControllerDoc
  end
end
