class Reservation < ApplicationRecord
  enum status: [:arrived, :pending, :cancelled, :blocked]
  enum purpose: [:academic, :entrepreneurship, :research, :personal]

  belongs_to :equipment
  belongs_to :user

  validates :status, :purpose, :start_time, :end_time, presence: true
  validate :date_range_valid, :not_overlapped

  def not_overlapped
    if start_time.present? && end_time.present?
      if Reservation.where('start_time < ? AND ? < end_time', end_time, start_time).exists?
        errors.add(:date, 'is overlapping with another reservation')
      end
    end
  end

  def date_range_valid
    return if start_time.present?

    errors.add(:start_time, "can't be in the past") if start_time < Date.today
    errors.add(:end_time, "can't be before start time") if end_time.present? && end_time < start_time
  end
end
