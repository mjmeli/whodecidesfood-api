require 'rails_helper'

RSpec.describe Decision, type: :model do
    let(:decision) { FactoryGirl.build :decision }
    subject { decision }

    it { should respond_to(:meal) }
    it { should respond_to(:location) }
    it { should respond_to(:comparison_id) }
    it { should respond_to(:participant_id) }

    it { should validate_presence_of :meal }
    it { should validate_presence_of :location }
    it { should validate_presence_of :comparison_id }
    it { should validate_presence_of :participant_id }

    it "should validate inclusion of meal in the valid meals" do
      expect(decision).to validate_inclusion_of(:meal).in_array(["Breakfast", "Lunch", "Dinner", "Snack"])
    end

    it { should belong_to :comparison }
    it { should belong_to :participant }

    describe "#increment_participant_score!" do
      it "increases the product score by 1" do
        participant = decision.participant
        expect{decision.increment_participant_score!}.to change{participant.score}.by(1)
      end
    end

    describe "#decrement_participant_score!" do
      it "decreases the product score by 1" do
        participant = decision.participant
        expect{decision.decrement_participant_score!}.to change{participant.score}.by(-1)
      end
    end
end
