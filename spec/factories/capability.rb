FactoryBot.define do
  factory :capability do
    name { Faker::Lorem.unique.word }
  end
end
