FactoryBot.define do
  factory :reservation do
    status { :confirmed }
    purpose { :academic }
    comment { 'Some comment' }
    start_time { DateTime.now + 1.hour }
    end_time { DateTime.now + 2.hour }
    equipment { nil }
    user { nil }
  end
end
