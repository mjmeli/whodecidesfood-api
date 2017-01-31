require 'rails_helper'

RSpec.describe Api::V1::ParticipantsController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create :user
    api_authorization_header @user.auth_token
  end

  # INDEX
  describe "GET #index" do
    before(:each) do
      comparison = FactoryGirl.create :comparison, owner: @user
      6.times { FactoryGirl.create :participant, comparison: comparison }
      get :index, params: { comparison_id: comparison.id }
    end

    it "returns 4 participants from the comparison" do
      participants_response = json_response
      expect(participants_response.length).to eql(6)
    end

    it { should respond_with 200 }
  end

  # SHOW
  describe "GET #show" do
    before(:each) do
      comparison = FactoryGirl.create :comparison, owner: @user
      4.times { FactoryGirl.create :participant, comparison: comparison }
      @participant = FactoryGirl.create :participant, comparison: comparison
      get :show, params: { comparison_id: comparison.id, id: @participant.id }
    end

    it "returns the participant record matching the id" do
      participants_response = json_response
      expect(participants_response[:id]).to eql @participant.id
      expect(participants_response[:name]).to eql @participant.name
    end

    skip "has the decision ids as an embedded object" do
      user_response = json_response
      expect(user_response[:decision_ids]).to eql []
    end

    it { should respond_with 200 }
  end

  # CREATE
  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        comparison = FactoryGirl.create :comparison, owner: @user
        participant_params = { name: "Fake Name" }
        post :create, params: { comparison_id: comparison.id, participant: participant_params }
      end

      it "returns the just participant record" do
        participants_response = json_response
        expect(participants_response[:id]).to be_present
        expect(participants_response[:name]).to eql("Fake Name")
        expect(participants_response[:score]).to eql(0)
      end

      it { should respond_with 201 }
    end

    context "when is not successfully created" do
      before(:each) do
        comparison = FactoryGirl.create :comparison, owner: @user
        participant_params = { name: "" }
        post :create, params: { comparison_id: comparison.id, participant: participant_params }
      end

      it "renders an errors json" do
        participants_response = json_response
        expect(participants_response).to have_key(:errors)
      end

      it "renders the json errors on why the comparison could not be created" do
        participants_response = json_response
        expect(participants_response[:errors][:name]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  # UPDATE
  describe "PUT/PATCH #update" do
    before(:each) do
      @comparison = FactoryGirl.create :comparison, owner: @user
      @participant = FactoryGirl.create :participant, comparison: @comparison
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, params: { comparison_id: @comparison.id,
                                 id: @participant.id,
                                 participant: { name: "New Name" } }
      end

      it "renders the json representation for the updated participant" do
        participants_response = json_response
        expect(participants_response[:name]).to eql "New Name"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, params: { comparison_id: @comparison.id,
                                 id: @participant.id,
                                 participant: { name: "" } }
      end

      it "renders an errors json" do
        participants_response = json_response
        expect(participants_response).to have_key(:errors)
      end

      it "renders the json errors on why the participant could not be created" do
        participants_response = json_response
        expect(participants_response[:errors][:name]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  # DESTROY
  describe "DELETE #destroy" do
    before(:each) do
      @comparison = FactoryGirl.create :comparison, owner: @user
      @participant = FactoryGirl.create :participant, comparison: @comparison
      delete :destroy, params: { comparison_id: @comparison.id, id: @participant.id }
    end

    it { should respond_with 204 }
  end
end
