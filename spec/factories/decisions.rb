FactoryGirl.define do
  factory :decision do
    participant
    comparison
    location { FFaker::Venue.name }
    meal { ["Breakfast", "Lunch", "Dinner", "Snack"].sample }
  end
end
