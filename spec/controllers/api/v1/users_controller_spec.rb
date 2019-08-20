require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  # INDEX
  describe "GET #index" do
    before(:each) do
      4.times { FactoryBot.create :user }
    end

    context "user is authenticated" do
      before(:each) do
        @user = FactoryBot.create :user
        api_authorization_header @user.auth_token
        get :index
      end

      it "returns only the current user" do
        user_response = json_response
        expect(user_response).to have_key(:email)
        expect(user_response[:email]).to eql(@user.email)
      end

      it { should respond_with 200 }
    end

    context "user is not authenticated" do
      before(:each) do
        @user = FactoryBot.create :user
        get :index
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = json_response
        expect(user_response[:errors]).to include "Not authenticated"
      end

      it { should respond_with 401 }
    end
  end

  # SHOW
  describe "GET #show" do
    context "user is authenticated" do
      before(:each) do
        @user = FactoryBot.create :user
        api_authorization_header @user.auth_token
        get :show, params: { id: @user.id }
      end

      it "returns the information about a reporter on a hash" do
        user_response = json_response
        expect(user_response[:email]).to eql @user.email
      end

      it "has the comparison ids as an embedded object" do
        user_response = json_response
        expect(user_response[:comparison_ids]).to eql []
      end

      it { should respond_with 200 }
    end

    context "user is not authenticated" do
      before(:each) do
        @user = FactoryBot.create :user
        get :show, params: { id: @user.id }
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user couldn't be shown" do
        user_response = json_response
        expect(user_response[:errors]).to include "Not authenticated"
      end

      it { should respond_with 401 }
    end

    context "user is authenticated with the wrong user" do
      before(:each) do
        @user1 = FactoryBot.create :user
        @user2 = FactoryBot.create :user
        api_authorization_header @user1.auth_token
        get :show, params: { id: @user2.id }
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user couldn't be shown" do
        user_response = json_response
        expect(user_response[:errors]).to include "Not authorized"
      end

      it { should respond_with 401 }
    end
  end

  # CREATE
  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @user_attributes = FactoryBot.attributes_for :user
        post :create, params: { user: @user_attributes }
      end

      it "renders the json representation for the user record just created" do
        user_response = json_response
        expect(user_response[:email]).to eql @user_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        # Not including the email --> invalid attributes
        @invalid_user_attributes = { password: "12345678",
                                     password_confirmation: "12345678" }
        post :create, params: { user: @invalid_user_attributes }
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do

    before(:each) do
      @user = FactoryBot.create :user
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, params: { id: @user.id,
                                 user: { email: "newmail@example.com" } }
      end

      it "renders the json representation for the updated user" do
        user_response = json_response
        expect(user_response[:email]).to eql "newmail@example.com"
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        patch :update, params: { id: @user.id, user: { email: "bademail.com" } }
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "is invalid"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryBot.create :user
      api_authorization_header @user.auth_token
      delete :destroy, params: { id: @user.id }
    end

    it { should respond_with 204 }
  end
end
