FactoryBot.define do
  factory :available_hour do
    day_of_week {:sunday}
    start_time { "2019-05-16 10:26:33" }
    end_time { "2019-05-16 11:26:33" }
    equipment { nil }
  end
end
