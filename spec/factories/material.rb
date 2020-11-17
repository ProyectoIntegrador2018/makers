FactoryBot.define do
  factory :material do
    name { Faker::Lorem.unique.word }
  end
end
