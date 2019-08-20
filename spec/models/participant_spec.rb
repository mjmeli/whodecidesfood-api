require 'rails_helper'

RSpec.describe Participant, type: :model do
  let(:participant) { FactoryBot.build :participant }
  subject { participant }

  it { should respond_to(:name) }
  it { should respond_to(:score) }
  it { should respond_to(:comparison_id) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :score }
  it { should validate_numericality_of(:score).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of :comparison_id }

  it { should belong_to :comparison }
  it { should have_many(:decisions) }
end
