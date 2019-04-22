FactoryBot.define do
  factory :available_hour do
    day_of_week { DateTime.now.wday }
    start_time { DateTime.now }
    end_time { DateTime.now + 10.hours }
    equipment { nil }
  end
end
