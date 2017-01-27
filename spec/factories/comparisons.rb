FactoryGirl.define do
  factory :comparison do
    title { FFaker::Lorem.sentence }
    association :owner, :factory => :user
  end
end
