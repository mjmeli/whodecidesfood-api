FactoryGirl.define do
  factory :participant do
    comparison
    name { FFaker::Name.name }
    score { rand() * 100 }
  end
end
