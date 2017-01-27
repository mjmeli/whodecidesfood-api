FactoryGirl.define do
  factory :comparison do
    title { FFaker::Lorem.sentence }
    owner 1
  end
end
