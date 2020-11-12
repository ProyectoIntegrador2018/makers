FactoryBot.define do
  factory :equipment do
    name { Faker::App.name }
    description do
      Faker::Lorem.sentence(word_count: 100,
                            supplemental: true,
                            random_words_to_add: 10)
    end
    image { Faker::LoremPixel.image(size: '300x260') }
    technical_description do
      Faker::Lorem.sentence(word_count: 100,
                            supplemental: true,
                            random_words_to_add: 10)
    end
    max_usage { 10 }
    rest_time { 1 }
    lab_space
  end
end
