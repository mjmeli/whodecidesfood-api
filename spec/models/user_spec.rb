require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryBot.build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token) }

  it { should be_valid }

  it { should have_many(:comparisons).with_foreign_key('owner_id') }

  # Test validations, should be provided by devise
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }
  # it { should validate_uniqueness_of(:auth_token) }

  # Test generation of unique authentication token for each user
  describe "#generate_authentication_token!" do
    it "generates a unique token" do
      allow(Devise).to receive(:friendly_token).and_return("auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryBot.create(:user, auth_token: "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end

  # Test dependency destroy of comparisons when a user is deleted
  describe "#comparisons association" do
    before do
      @user.save
      3.times { FactoryBot.create :comparison, owner: @user }
    end

    it "destroys the associated comparisons on self destruct" do
      comparisons = @user.comparisons
      @user.destroy
      comparisons.each do |comparison|
        expect(Comparison.find(comparison.id)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
