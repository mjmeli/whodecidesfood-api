require 'rails_helper'

RSpec.describe Api::V1::ParticipantsController, type: :controller do
  # INDEX
  describe "GET #index" do
    before(:each) do
      comparison = FactoryGirl.create :comparison
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
      comparison = FactoryGirl.create :comparison
      4.times { FactoryGirl.create :participant, comparison: comparison }
      @participant = FactoryGirl.create :participant, comparison: comparison
      get :show, params: { comparison_id: comparison.id, id: @participant.id }
    end

    it "returns the participant record matching the id" do
      participants_response = json_response
      expect(participants_response[:id]).to eql @participant.id
      expect(participants_response[:name]).to eql @participant.name
    end

    it { should respond_with 200 }
  end

  # CREATE
  describe "POST #create" do
    before(:each) do
      comparison = FactoryGirl.create :comparison
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
end
