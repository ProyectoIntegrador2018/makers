FactoryBot.define do
  factory :reservation do
    status { :confirmed }
    purpose { :academic }
    comment { 'Some comment' }
    start_time { DateTime.tomorrow.beginning_of_day + 7.hour }
    end_time { DateTime.tomorrow.beginning_of_day + 8.hour }
    equipment { nil }
    user { nil }

    trait :pending do
      status { :pending }
    end

    trait :confirmed do
      status { :confirmed }
    end

    trait :rejected do
      status { :rejected }
    end

    trait :cancelled do
      status { :cancelled }
    end

    trait :blocked do
      status { :blocked }
    end
  end
end
