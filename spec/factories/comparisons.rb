FactoryBot.define do
  factory :comparison do
    title { FFaker::CheesyLingo.title }
    association :owner, :factory => :user
  end
end
