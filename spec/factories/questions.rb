FactoryGirl.define do
  factory :question do
  	user { FactoryGirl.create(:user) }
    exclusive { [true, false].sample }
    limit { Faker::Number.between(100, 1000) }
  end
end
