class AvailableHour < ApplicationRecord
  enum day_of_week: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

  belongs_to :equipment
end
