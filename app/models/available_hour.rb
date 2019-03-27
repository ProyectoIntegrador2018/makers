class AvailableHour < ApplicationRecord
  enum day_of_week: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday ]

  belongs_to :equipment
end
