FactoryBot.define do
  factory :user do
    given_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{Faker::Internet.user_name}@itesm.mx" }
    institutional_id { "A0#{Faker::Number.number(digits: 7)}" }
    role { :user }
    password { '12345678' }
    password_confirmation { '12345678' }
    confirmed_at { Time.current }
    created_at { Time.current }

    trait :unconfirmed do
      confirmed_at { nil }
    end

    trait :super_admin do
      role { :superadmin }
    end

    trait :lab_space_admin do
      role { :lab_space_admin }
    end

    trait :lab_admin do
      role { :lab_admin }
    end
  end
end
