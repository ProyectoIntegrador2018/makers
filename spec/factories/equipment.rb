FactoryBot.define do
  factory :equipment do
    name { Faker::App.name }
    description do
      Faker::Lorem.sentence(word_count: 100,
                            supplemental: true,
                            random_words_to_add: 10)
    end
    image { Faker::LoremPixel.image(size: '300x260') }
    technical_description {}
    max_usage { 5 }
    rest_time { 1 }
    lab_space { nil }

    transient do
      caps_amount { 3 }
      mats_amount { 3 }
    end

    trait :with_technical_description do
      image do
        Faker::Lorem.sentence(word_count: 300,
                              supplemental: true,
                              random_words_to_add: 15)
      end
    end

    trait :with_available_hour do
      after(:create) do |equipment|
        create :available_hour, equipment: equipment
      end
    end

    trait :with_capabilities do
      after(:create) do |equipment, evaluator|
        create_list(:capability, evaluator.caps_amount, equipment: [equipment])
      end
    end

    trait :with_materials do
      after(:create) do |equipment, evaluator|
        create_list(:material, evaluator.mats_amount, equipment: [equipment])
      end
    end
  end
end
