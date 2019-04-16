FactoryBot.define do
  factory :equipment do
    name {Faker::App.name}
    description {Faker::Lorem.sentence(100, true, 10)}
    image {}
    technical_description {}
    lab_space { nil }

    trait :with_image do
      image { Faker::LoremPixel.image("300x260") }
    end

    trait :with_technical_description do
      image { Faker::Lorem.sentence(300, true, 15) }
    end
  end
end
