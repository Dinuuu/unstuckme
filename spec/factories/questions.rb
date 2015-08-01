FactoryGirl.define do
  factory :question do
    creator { Faker::Lorem.characters(10) }
    exclusive { [true, false].sample }
  end
end
