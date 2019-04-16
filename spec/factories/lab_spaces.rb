FactoryBot.define do
  factory :lab_space do
    name {Faker::App.name}
    description { Faker::Lorem.sentence(30, true, 10) }
    hours {}
    location {"Innovaction Gym"}
    contact_email {}
    contact_phone {}
    image {}
    lab {nil}

    trait :with_image do
      image { Faker::LoremPixel.image("300x260") }
    end
  end
end
