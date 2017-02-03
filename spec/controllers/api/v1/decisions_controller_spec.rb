require 'rails_helper'

# TODO: search TODO in this file

RSpec.describe Api::V1::DecisionsController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create :user
    api_authorization_header @user.auth_token
  end

  # INDEX
  describe "GET #index" do
    before(:each) do
      comparison = FactoryGirl.create :comparison, owner: @user
      6.times { FactoryGirl.create :decision, comparison: comparison }
      get :index, params: { comparison_id: comparison.id }
    end

    it "returns 4 decisions from the comparison" do
      decisions_response = json_response
      expect(decisions_response.length).to eql(6)
    end

    it { should respond_with 200 }
  end

  # SHOW
  describe "GET #show" do
    before(:each) do
      comparison = FactoryGirl.create :comparison, owner: @user
      4.times { FactoryGirl.create :decision, comparison: comparison }
      @decision = FactoryGirl.create :decision, comparison: comparison
      get :show, params: { comparison_id: comparison.id, id: @decision.id }
    end

    it "returns the decision record matching the id" do
      decisions_response = json_response
      expect(decisions_response[:id]).to eql @decision.id
      expect(decisions_response[:comparison_id]).to eql @decision.comparison_id
      expect(decisions_response[:location]).to eql @decision.location
      expect(decisions_response[:meal]).to eql @decision.meal
    end

    it { should respond_with 200 }
  end

  # CREATE
  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        comparison = FactoryGirl.create :comparison, owner: @user
        @participant = FactoryGirl.create :participant, comparison: comparison
        @original_score = @participant.score
        decision_params = { meal: "Breakfast", location: "Fake Location", participant_id: @participant.id }
        post :create, params: { comparison_id: comparison.id, decision: decision_params }
      end

      it "returns the just decision record" do
        decisions_response = json_response
        expect(decisions_response[:id]).to be_present
        expect(decisions_response[:meal]).to eql("Breakfast")
        expect(decisions_response[:location]).to eql("Fake Location")
      end

      it "increments the participant's score" do
        @participant.reload
        expect(@participant.score).to eql(@original_score + 1)
      end

      it { should respond_with 201 }
    end

    context "when is not successfully created" do
      before(:each) do
        comparison = FactoryGirl.create :comparison, owner: @user
        participant = FactoryGirl.create :participant, comparison: comparison
        decision_params = { meal: "Dessert", location: "", participant_id: participant.id }
        post :create, params: { comparison_id: comparison.id, decision: decision_params }
      end

      it "renders an errors json" do
        decisions_response = json_response
        expect(decisions_response).to have_key(:errors)
      end

      it "renders the json errors on why the decision could not be created" do
        decisions_response = json_response
        expect(decisions_response[:errors][:location]).to include "can't be blank"
        expect(decisions_response[:errors][:meal]).to include "is not included in the list"
      end

      it { should respond_with 422 }
    end
  end

  # UPDATE
  describe "PUT/PATCH #update" do
    before(:each) do
      @comparison = FactoryGirl.create :comparison, owner: @user
      @participant = FactoryGirl.create :participant, comparison: @comparison
      @decision = FactoryGirl.create :decision, meal: "Breakfast", comparison: @comparison, participant: @participant
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, params: { comparison_id: @comparison.id,
                                 id: @decision.id,
                                 decision: { meal: "Dinner" } }
      end

      it "renders the json representation for the updated decision" do
        decisions_response = json_response
        expect(decisions_response[:meal]).to eql "Dinner"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, params: { comparison_id: @comparison.id,
                                 id: @decision.id,
                                 decision: { meal: "Snacky Snack" } }
      end

      it "renders an errors json" do
        decisions_response = json_response
        expect(decisions_response).to have_key(:errors)
      end

      it "renders the json errors on why the decision could not be created" do
        decisions_response = json_response
        expect(decisions_response[:errors][:meal]).to include "is not included in the list"
      end

      it { should respond_with 422 }
    end

    context "when it successfully updates participant" do
      before(:each) do
        @new_participant = FactoryGirl.create :participant, comparison: @comparison
        @original_score = @participant.score
        @new_score = @new_participant.score
        patch :update, params: { comparison_id: @comparison.id,
                                 id: @decision.id,
                                 decision: { participant_id: @new_participant.id } }
      end

      it "changes the participant id" do
        decisions_response = json_response
        expect(decisions_response[:participant_id]).to eql(@new_participant.id)
      end

      it "decrements the old participant's score" do
        @participant.reload
        expect(@participant.score).to eql(@original_score - 1)
      end

      it "increments the new participant's score" do
        @new_participant.reload
        expect(@new_participant.score).to eql(@new_score + 1)
      end

      it { should respond_with 200 }
    end
  end

  # DESTROY
  describe "DELETE #destroy" do
    before(:each) do
      comparison = FactoryGirl.create :comparison, owner: @user
      participant = FactoryGirl.create :participant, comparison: comparison
      original_score = participant.score
      decision = FactoryGirl.create :decision, comparison: comparison, participant_id: participant.id
      delete :destroy, params: { comparison_id: comparison.id, id: decision.id }
    end

    it { should respond_with 204 }
  end
end
