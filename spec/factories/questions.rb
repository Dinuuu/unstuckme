FactoryGirl.define do
  factory :question do
    creator { Faker::Lorem.characters(10) }
    exclusive { [true, false].sample }
    limit { Faker::Number.between(100, 1000) }
  end
end
