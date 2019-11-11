FactoryBot.define do
  factory :reservation do
    status { :pending }
    purpose { :academic }
    comment { 'Some comment' }
    start_time { DateTime.tomorrow.beginning_of_day + 1.hour }
    end_time { DateTime.tomorrow.beginning_of_day + 2.hour }
    equipment { nil }
    user { nil }
  end
end
