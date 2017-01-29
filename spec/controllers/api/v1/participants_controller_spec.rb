require 'rails_helper'

RSpec.describe Api::V1::ParticipantsController, type: :controller do
  # INDEX
  describe "GET #index" do
    before(:each) do
      comparison = FactoryGirl.create :comparison
      4.times { FactoryGirl.create :participant, comparison: comparison }
      get :index, params: { comparison_id: comparison.id }
    end

    it "returns 4 participants from the comparison" do
      participants_response = json_response
      expect(participants_response.length).to eql(4)
    end

    it { should respond_with 200 }
  end

end
