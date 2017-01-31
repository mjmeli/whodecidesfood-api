if Rails.env.development?
  module ComparisonsControllerDoc extend Apipie::DSL::Concern

    def_param_group :comparison do
      param :comparison, Hash, :action_aware => true, :required => true do
        param :title, String, :required => true, :desc => "Title for the comparison"
      end
    end

    # show false
    # error :code => 401, :desc => "Unauthorized"
    # error :code => 404, :desc => "Not Found", :meta => {:anything => "you can think of"}
    # param :session, String, :desc => "user is logged in", :required => true
    # param :regexp_param, /^[0-9]* years/, :desc => "regexp param"
    # param :array_param, [100, "one", "two", 1, 2], :desc => "array validator"
    # param :boolean_param, [true, false], :desc => "array validator with boolean"
    # param :proc_param, lambda { |val|
    #   val == "param value" ? true : "The only good value is 'param value'."
    # }, :desc => "proc validator"
    # param :param_with_metadata, String, :desc => "", :meta => [:your, :custom, :metadata]
    # description "method description"
    # formats ['json', 'jsonp', 'xml']
    # meta :message => "Some very important info"
    # example " 'user': {...} "
    # see "users#showme", "link description"
    # see :link => "users#update", :desc => "another link description"

    api :GET, "/comparisons", "Get all comparisons for the authenticated user"
    header "Authorization", "Session authentication token for the user", :required => true
    error 401, "Unauthorized"
    def index
      # Stub
    end

    api :GET, "/comparisons/:id", "Get comparison information by ID"
    header "Authorization", "Session authentication token for the user", :required => true
    param :id, :number, :desc => "Comparison ID", :required => true
    error 401, "Unauthorized"
    error 404, "Comparison does not exist"
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
