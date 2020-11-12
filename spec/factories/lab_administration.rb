FactoryBot.define do
  factory :lab_administration do
    admin { association :user }
    space { association :lab }
    # space { association :lab_space } # either one works since its polymorphic assoiciation
  end
end
