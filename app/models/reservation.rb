class Reservation < ApplicationRecord
  enum status: [:confirmed, :pending, :rejected, :complete, :cancelled, :blocked]
  enum purpose: [:academic, :entrepreneurship, :research, :personal]

  belongs_to :equipment
  belongs_to :user

  validates :status, :purpose, :start_time, :end_time, presence: true
  validate :date_range_valid, :not_overlapped, if: -> { start_time_changed? || end_time_changed? }
  validate :is_available, on: :create

  scope :upcoming, ->(limit) { where('start_time > ?', Time.current).order(:start_time).limit(limit) }
  scope :future, -> { where('start_time > ?', Time.current).order(:start_time) }

  after_save :check_status, if: -> { previous_changes.include?(:status) }

  def available_at(st, et, day)
    slots = equipment.available_hours
                               .where(day_of_week: day)
                               .order(start_time: :asc)
    return false if slots.empty?

    last_start = nil
    last_end = slots.first.start_time
    slots.each do |slot|
      return false unless eq(last_end, slot.start_time)

      last_start = slot.start_time
      last_end = slot.end_time
      break if bigger(slot.end_time, et)
    end

    (bigger(st, slots.first.start_time) || eq(st, slots.first.start_time)) && !bigger(et, last_end)
  end

  # Checks if all available blocks that the reservation spans are consecutive
  # and encompass the reservation itself
  def is_available
    return unless start_time.present? && end_time.present?

    reservation_hours = (end_time - start_time) / 1.hour
    day = start_time.wday
    st = start_time
    et = reservation_hours > 24 ? end_time.end_of_day : end_time
    while reservation_hours > 0 do
      unless available_at(st, et, day)
        errors.add(:start_time, I18n.t('activerecord.errors.models.reservation.attributes.date.available_hours'))
        return
      end
      if overnight?
        st = start_time.beginning_of_day
      end
      et = reservation_hours > 24 ? end_time.end_of_day : end_time
      day = (day + 1) % 7
      reservation_hours -= 24
    end
  end

  def date_range_valid
    return unless start_time.present? && end_time.present?

    errors.add(:start_time, I18n.t('activerecord.errors.models.reservation.attributes.date.past')) if start_time < Time.current
    errors.add(:end_time, I18n.t('activerecord.errors.models.reservation.attributes.date.start_time')) if end_time <= start_time
  end

  def not_overlapped
    return unless start_time.present? && end_time.present?

    remove_overlapped if blocked?
    if overlapped_reservations.exists?
      errors.add(:date, I18n.t('activerecord.errors.models.reservation.attributes.date.overlapping'))
    end
  end

  def remove_overlapped
    overlapped_reservations.each(&:cancelled!)
  end

  def overlapped_reservations
    statuses = Reservation.statuses
    equipment.reservations
             .where.not(id: id)
             .where('start_time < ? AND ? < end_time', end_time, start_time)
             .where.not('status = ? OR status = ? OR status = ?', statuses[:cancelled], statuses[:rejected], statuses[:pending])
  end

  def overnight?
    end_time.to_date > start_time.to_date
  end

  def accept
  end

  private

  def bigger(time_a, time_b)
    time_a.strftime("%H%M") > time_b.strftime("%H%M")
  end

  def eq(time_a, time_b)
    time_a.strftime("%H%M") == time_b.strftime("%H%M")
  end

  def check_status
    MakersMailer.status_email(self).deliver_now if not blocked?
  end
end
