module UsersControllerDoc extend Apipie::DSL::Concern

  def_param_group :user do
    param :user, Hash, :action_aware => true, :required => true do
      param :email, String, :required => true, :desc => "User's email address"
      param :password, String, :required => true, :desc => "User's password"
      param :password_confirmation, String, :required => true, :desc => "User's password confirmation"
    end
  end

  api :GET, "/users", "Get user information for current user"
  header "Authorization", "Session authentication token for the user", :required => true
  error 401, "Unauthorized"
  example '{
"id": 1,
"email": "brinda@boyer.com",
"created_at": "2017-02-01T00:07:49.205Z",
"updated_at": "2017-02-01T00:07:49.205Z",
"auth_token": "7FAYZgr8xtQMoDdJycmz",
"comparison_ids": [
  1,
  7,
  13
]
}'
  def index
    # Stub
  end

  api :GET, "/users/:id", "Get user information by ID"
  header "Authorization", "Session authentication token for the user", :required => true
  param :id, :number, :desc => "User ID", :required => true
  error 401, "Unauthorized"
  example '{
"id": 1,
"email": "brinda@boyer.com",
"created_at": "2017-02-01T00:07:49.205Z",
"updated_at": "2017-02-01T00:07:49.205Z",
"auth_token": "7FAYZgr8xtQMoDdJycmz",
"comparison_ids": [
  1,
  7,
  13
]
}'
  def show
    # Stub
  end

  api :POST, "/users", "Create a new user"
  param_group :user
  error 422, "Unable to create the user (probably due to validation issues)"
  def create
    # Stub
  end

  api :PATCH, "/users/:id", "Update an existing user"
  header "Authorization", "Session authentication token for the user", :required => true
  param :id, :number, :desc => "User ID", :required => true
  param_group :user
  error 401, "Unauthorized"
  error 422, "Unable to update the user (probably due to validation issues)"
  def update
    # Stub
  end

  api :DELETE, "/users/:id", "Delete an existing user"
  header "Authorization", "Session authentication token for the user", :required => true
  param :id, :number, :desc => "User ID", :required => true
  error 401, "Unauthorized"
  def destroy
    # Stub
  end
end
