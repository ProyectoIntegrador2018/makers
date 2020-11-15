FactoryBot.define do
  factory :available_hour do
    day_of_week { tomorrow.wday }
    start_time { tomorrow.at_noon }
    end_time { tomorrow.at_noon + 10.hours }
    equipment { nil }
  end
end
