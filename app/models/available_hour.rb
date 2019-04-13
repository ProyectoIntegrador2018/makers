class AvailableHour < ApplicationRecord
  END_OF_DAY = Time.parse('2000-01-01T23:59:59.000Z')
  enum day_of_week: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

  belongs_to :equipment
  validates :start_time, :end_time, :day_of_week, presence: true
  validate :date_range_valid

  def date_range_valid
    return if start_time.blank?

    errors.add(:end_time, "can't be before start time") if end_time.present? && end_time < start_time
  end
end
