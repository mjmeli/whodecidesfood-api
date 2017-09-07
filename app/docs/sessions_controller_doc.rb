module SessionsControllerDoc extend Apipie::DSL::Concern

  def_param_group :session do
    param :session, Hash, :action_aware => true, :required => true do
      param :email, String, :required => true, :desc => "User's email address"
      param :password, String, :required => true, :desc => "User's password"
    end
  end

  api :POST, "/sessions", "Create a new session for user (get authentication token)"
  error 422, "Unable to create new session due to invalid email or password"
  param_group :session
  def create
    # Stub
  end

  api :DELETE, "/sessions/:id", "Delete a session by authentication token"
  param :id, String, :desc => "The authentication token being invalidated", :required => true
  def destroy
    # Stub
  end
end
