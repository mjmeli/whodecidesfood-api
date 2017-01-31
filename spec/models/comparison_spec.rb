require 'rails_helper'

RSpec.describe Comparison, type: :model do
  let(:comparison) { FactoryGirl.build :comparison }
  subject { comparison }

  it { should respond_to(:title) }
  it { should respond_to(:owner_id) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :owner_id }

  it { should belong_to :owner }

  it { should have_many :participants }
  it { should have_many :decisions }

  # testing sorting by creation date functionality
  describe ".recent" do
    before(:each) do
      @comparison1 = FactoryGirl.create :comparison
      @comparison2 = FactoryGirl.create :comparison
      @comparison3 = FactoryGirl.create :comparison
      @comparison4 = FactoryGirl.create :comparison

      # touch some comparisons to update them
      @comparison2.touch
      @comparison3.touch
    end

    it "returns the most recently updated records" do
      expect(Comparison.recent).to match_array([@comparison3, @comparison2, @comparison4, @comparison1])
    end
  end
end
