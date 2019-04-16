FactoryBot.define do
  factory :user do
    given_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email {"A01192508@itesm.mx"}
    institutional_id {"A01192508"}
    role {:user}
    password {"12345678"}
    password_confirmation {"12345678"}
    confirmed_at {Time.current}
    created_at {Time.current}
  end
end
