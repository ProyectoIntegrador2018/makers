FactoryBot.define do
  factory :reservation do
    status {:confirmed}
    purpose {:academic}
    comment {"Some comment"}
    start_time { "2019-05-16 10:26:33" }
    end_time { "2019-05-16 11:26:33" }
    equipment { nil }
    user { nil }
  end
end
