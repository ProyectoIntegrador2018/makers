FactoryBot.define do
  factory :lab_space do
    name {Faker::App.name}
    description { Faker::Lorem.sentence(word_count: 30, supplemental: true, random_words_to_add: 10) }
    hours {}
    location {"Innovaction Gym"}
    contact_email {}
    contact_phone {}
    image { Faker::LoremPixel.image(size: "300x260") }
    lab
    user
  end
end
