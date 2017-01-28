require 'rails_helper'

RSpec.describe Api::V1::ComparisonsController, type: :controller do
  # SHOW
  describe "GET #show" do
    before(:each) do
      @comparison = FactoryGirl.create :comparison
      get :show, params: { id: @comparison.id }
    end

    it "returns the information about a reporter on a hash" do
      comparison_response = json_response
      expect(comparison_response[:title]).to eql @comparison.title
    end

    it { should respond_with 200 }
  end

  # INDEX
  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :comparison }
      get :index
    end

    it "returns 4 records from the database" do
      comparison_response = json_response
      expect(comparison_response.length).to eq(4)
    end

    it { should respond_with 200 }
  end

  # CREATE
  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @comparison_attributes = FactoryGirl.attributes_for :comparison
        api_authorization_header user.auth_token
        post :create, params: { user_id: user.id, comparison: @comparison_attributes}
      end

      it "renders the json representation for the comparison record just created" do
        comparison_response = json_response
        expect(comparison_response[:title]).to eql @comparison_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when is not successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_comparison_attributes = { title: "" }
        api_authorization_header user.auth_token
        post :create, params: { user_id: user.id, comparison: @invalid_comparison_attributes}
      end

      it "renders an errors json" do
        comparison_response = json_response
        expect(comparison_response).to have_key(:errors)
      end

      it "renders the json errors on why the comparison could not be created" do
        comparison_response = json_response
        expect(comparison_response[:errors][:title]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  # UPDATE
  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @comparison = FactoryGirl.create :comparison, owner: @user
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, params: { user_id: @user.id, id: @comparison.id,
                                comparison: { title: "Updated title" } }
      end

      it "renders the json representation for the updated comparison" do
        comparison_response = json_response
        expect(comparison_response[:title]).to eql "Updated title"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, params: { user_id: @user.id, id: @comparison.id,
                                comparison: { title: "" } }
      end

      it "renders an errors json" do
        comparison_response = json_response
        expect(comparison_response).to have_key(:errors)
      end

      it "renders the json errors on why the comparison could not be created" do
        comparison_response = json_response
        expect(comparison_response[:errors][:title]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  # DELETE
  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @comparison = FactoryGirl.create :comparison, owner: @user
      api_authorization_header @user.auth_token
      delete :destroy, params: { user_id: @user.id, id: @comparison.id }
    end

    it { should respond_with 204 }
  end
end
