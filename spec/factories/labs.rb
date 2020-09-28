FactoryBot.define do
  factory :lab do
    name {Faker::App.name}
    description { Faker::Lorem.sentence(word_count: 30, supplemental: true, random_words_to_add: 10) }
    location { "CIAP 628-F" }
    image { }

    trait :with_image do
      image { Faker::LoremPixel.image(size: "300x260") }
    end
  end
end
