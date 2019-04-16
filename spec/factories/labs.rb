FactoryBot.define do
  factory :lab do
    name {Faker::App.name}
    description { Faker::Lorem.sentence(30, true, 10) }
    location { "CIAP 628-F" }
    image { }

    trait :with_image do
      image { Faker::LoremPixel.image("300x260") }
    end
  end
end
