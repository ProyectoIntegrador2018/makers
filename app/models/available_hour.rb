class AvailableHour < ApplicationRecord
  audited
  enum day_of_week: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

  belongs_to :equipment
  validates :start_time, :end_time, :day_of_week, presence: true
  validate :date_range_valid

  def date_range_valid
    return if start_time.blank?

    errors.add(:end_time, "can't be before start time") if end_time.present? && end_time < start_time
  end

  def formatted_start_time
    TimeUtils.extract_time(start_time)
  end

  def formatted_end_time
    TimeUtils.extract_time(end_time)
  end
end
