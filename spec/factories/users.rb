FactoryGirl.define do
  factory :user do
  	device_token { Faker::Lorem.characters }
  end
end
