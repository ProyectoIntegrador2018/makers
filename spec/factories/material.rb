FactoryBot.define do
  factory :material do
    name { Faker::Lorem.unique.word }
    equipment
  end
end
