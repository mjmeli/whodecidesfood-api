require 'rails_helper'

RSpec.describe Api::V1::ComparisonsController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create :user
    api_authorization_header @user.auth_token
  end

  # SHOW
  describe "GET #show" do
    before(:each) do
      @comparison = FactoryGirl.create :comparison, owner: @user
      get :show, params: { id: @comparison.id }
    end

    it "returns the information about a reporter on a hash" do
      comparison_response = json_response
      expect(comparison_response[:title]).to eql @comparison.title
    end

    it "has the owner as an embedded object" do
      comparison_response = json_response
      expect(comparison_response[:owner][:email]).to eql @comparison.owner.email
    end

    it { should respond_with 200 }
  end

  # INDEX
  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :comparison, owner: @user }
    end

    context "when does not receive the comparison_id parameter" do
      before(:each) do
        get :index
      end

      it "returns 4 records from the database" do
        comparison_response = json_response
        expect(comparison_response.length).to eq(4)
      end

      it "returns the user object into each product with id and email only" do
        comparison_response = json_response
        comparison_response.each do |cr|
          expect(cr[:owner]).to be_present
          expect(cr[:owner][:id]).to be_present
          expect(cr[:owner][:email]).to be_present
          expect(cr[:owner][:auth_token]).to_not be_present
        end
      end

      it { should respond_with 200 }
    end

    context "when receives the comparison_id parameter" do
      before(:each) do
        original_comparison_ids = @user.comparison_ids
        3.times { FactoryGirl.create :comparison, owner: @user }
        get :index, params: { comparison_ids: original_comparison_ids }
      end

      it "returns just the comparisons specified" do
        comparison_response = json_response
        expect(comparison_response.length).to eq(4)
        comparison_response.each do |cr|
          expect(cr[:owner][:email]).to eql @user.email
        end
      end

      it { should respond_with 200 }
    end
  end

  # CREATE
  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @comparison_attributes = FactoryGirl.attributes_for :comparison
        post :create, params: { user_id: @user.id, comparison: @comparison_attributes}
      end

      it "renders the json representation for the comparison record just created" do
        comparison_response = json_response
        expect(comparison_response[:title]).to eql @comparison_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when is not successfully created" do
      before(:each) do
        @invalid_comparison_attributes = { title: "" }
        post :create, params: { user_id: @user.id, comparison: @invalid_comparison_attributes}
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
      @comparison = FactoryGirl.create :comparison, owner: @user
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
      @comparison = FactoryGirl.create :comparison, owner: @user
      delete :destroy, params: { user_id: @user.id, id: @comparison.id }
    end

    it { should respond_with 204 }
  end
end
