# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
case Rails.env
when "development"
  # Users with comparisons
  5.times do
    user = FactoryGirl.create :user

    # Create comparisons with participants
    3.times do
      comparison = FactoryGirl.create :comparison, owner: user
      2.times do
        participant = FactoryGirl.create :participant, comparison: comparison
        5.times { FactoryGirl.create :decision, comparison: comparison, participant: participant }
      end
    end
  end

  # Users with no comparisons
  3.times { FactoryGirl.create :user }
end
