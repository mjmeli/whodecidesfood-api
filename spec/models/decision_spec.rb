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
end
