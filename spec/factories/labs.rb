FactoryBot.define do
  factory :lab do
    name {Faker::App.name}
    description { Faker::Lorem.sentence(word_count: 30, supplemental: true, random_words_to_add: 10) }
    location { "CIAP 628-F" }
    location_link { "place_holder" }
    image { }
    user

    trait :with_image do
      image { Faker::LoremPixel.image(size: "300x260") }
    end

    trait :with_lab_space do
      after(:create) do |lab|
        create :lab_space, lab: lab
      end
    end

    trait :with_equipment do
      after(:create) do |lab|
        ls = create :lab_space, lab: lab
        e = create :equipment, :with_available_hour, lab_space: ls 
      end
    end
  end
end
