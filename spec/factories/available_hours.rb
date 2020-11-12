FactoryBot.define do
  factory :available_hour do
    day_of_week { DateTime.tomorrow.wday }
    start_time { DateTime.tomorrow.beginning_of_day }
    end_time { DateTime.tomorrow.beginning_of_day + 10.hours }
    equipment
  end
end
