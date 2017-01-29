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
    3.times { FactoryGirl.create :comparison, owner: user }
  end

  # Users with no comparisons
  3.times { FactoryGirl.create :user }
end
