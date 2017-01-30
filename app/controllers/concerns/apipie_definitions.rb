module ApipieDefinitions extend ActiveSupport::Concern
  included do
    def_param_group :user do
      param :user, Hash, :action_aware => true, :required => true do
        param :email, String, :required => true, :desc => "User's email address"
        param :password, String, :required => true, :desc => "User's password"
        param :password_confirmation, String, :required => true, :desc => "User's password confirmation"
      end
    end

    def_param_group :session do
      param :session, Hash, :action_aware => true, :required => true do
        param :email, String, :required => true, :desc => "User's email address"
        param :password, String, :required => true, :desc => "User's password"
      end
    end

    def_param_group :comparison do
      param :comparison, Hash, :action_aware => true, :required => true do
        param :title, String, :required => true, :desc => "Title for the comparison"
      end
    end

    def_param_group :participant do
      param :participant, Hash, :action_aware => true, :required => true do
        param :name, String, :required => true, :desc => "Name for the participant"
      end
    end
  end
end
