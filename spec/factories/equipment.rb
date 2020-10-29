FactoryBot.define do
  factory :equipment do
    name { Faker::App.name }
    description do
      Faker::Lorem.sentence(word_count: 100,
                            supplemental: true,
                            random_words_to_add: 10)
    end
    image {}
    technical_description {}
    max_usage { 10 }
    rest_time { 1 }
    lab_space { nil }

    trait :with_image do
      image { Faker::LoremPixel.image(size: '300x260') }
    end

    trait :with_technical_description do
      image do
        Faker::Lorem.sentence(word_count: 300,
                              supplemental: true,
                              random_words_to_add: 15)
      end
    end
  end
end
