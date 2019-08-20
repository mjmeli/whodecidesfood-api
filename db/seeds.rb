# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def create_comparisons_for_user(user)
  3.times do
    comparison = FactoryBot.create :comparison, owner: user
    2.times do
      participant = FactoryBot.create :participant, comparison: comparison
      5.times { FactoryBot.create :decision, comparison: comparison, participant: participant }
    end
  end
end

case Rails.env
when "development"
  # Users with comparisons
  5.times do
    user = FactoryBot.create :user

    # Create comparisons with participants
    create_comparisons_for_user(user)
  end

  # Users with no comparisons
  3.times { FactoryBot.create :user }

  # Known user
  user = FactoryBot.create :user, email: "foo@bar.com", password: "test123", password_confirmation: "test123"
  create_comparisons_for_user(user)
end
