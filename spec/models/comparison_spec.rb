require 'rails_helper'

RSpec.describe Comparison, type: :model do
  let(:comparison) { FactoryGirl.build :comparison }
  subject { comparison }

  it { should respond_to(:title) }
  it { should respond_to(:owner_id) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :owner_id }

  it { should belong_to :owner }
end
