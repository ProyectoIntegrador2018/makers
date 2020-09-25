FactoryBot.define do
  factory :equipment do
    name {Faker::App.name}
    description {Faker::Lorem.sentence(word_count: 100, supplemental: true, random_words_to_add: 10)}
    image {}
    technical_description {}
    lab_space { nil }

    trait :with_image do
      image { Faker::LoremPixel.image(size: "300x260") }
    end

    trait :with_technical_description do
      image { Faker::Lorem.sentence(word_count: 300, supplemental: true, random_words_to_add: 15) }
    end
  end
end
