if Rails.env.development?
  module TestControllerDoc extend Apipie::DSL::Concern

    api :GET, "/test", "Test user's connection and authentication"
    header "Authorization", "Session authentication token for the user", :required => false
    example '{
    message: "You\'re connected!",
    authenticated: true/false
}'
    def index
      # Stub
    end
  end
else
  module TestControllerDoc
  end
end
