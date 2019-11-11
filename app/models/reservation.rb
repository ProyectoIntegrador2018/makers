class Reservation < ApplicationRecord
  enum status: [:confirmed, :pending, :rejected, :complete, :cancelled, :blocked]
  enum purpose: [:academic, :entrepreneurship, :research, :personal]

  belongs_to :equipment
  belongs_to :user

  validates :status, :purpose, :start_time, :end_time, presence: true
  validate :date_range_valid, :not_overlapped, if: -> { start_time_changed? || end_time_changed? }
  validate :date_is_available, on: :create

  scope :upcoming, ->(limit) { where('start_time > ?', Time.now).order(:start_time).limit(limit) }
  scope :future, -> { where('start_time > ?', Time.now).order(:start_time) }

  after_save :check_cancellation, if: -> { previous_changes.include?(:status) }

  def overlapped_reservations
    equipment.reservations
             .where.not(id: id)
             .where('start_time < ? AND ? < end_time', end_time, start_time)
             .where.not('status = ?', Reservation.statuses[:cancelled])
             .where.not('status = ?', Reservation.statuses[:rejected])
  end

  def not_overlapped
    if start_time.present? && end_time.present?
      remove_overlapped if blocked?
      if overlapped_reservations.exists?
        errors.add(:date, I18n.t('activerecord.errors.models.reservation.attributes.date.overlapping'))
      end
    end
  end

  def get_first_available_overlap(st, et, day)
    chosen_time_slot = { start: TimeUtils.extract_time(st),
                         end:  TimeUtils.extract_time(et) }
    availabilities_on_selected_day = equipment.available_hours.where(day_of_week: day)
    availabilities_on_selected_day.find { |availability| TimeSlotComparison.overlap?(chosen_time_slot, availability) }
  end

  def date_is_available
    return unless start_time.present? && end_time.present?
    st = start_time
    day = start_time.wday
    et = end_time
    et = Time.new.end_of_day if bigger(st, end_time) # this means reservation is overnight
    look_for_available_overlaps(st, et, day)
  end

  def look_for_available_overlaps(st, et, day)
    begin
      first_match = get_first_available_overlap(st, et, day)
      if first_match.blank?
        errors.add(:date, I18n.t('activerecord.errors.models.reservation.attributes.date.available_hours'))
        return
      else # change st to be the end of the first_match
        st = first_match.end_time
        day = (day + 1) % 7 if bigger(start_time, st) # check for next day, if overnight reservation
      end
      # continue if end_time > first_match.end_time
    end while bigger(end_time, st)
  end

  def remove_overlapped
    overlapped_reservations.each(&:cancelled!)
  end

  def date_range_valid
    return if start_time.blank?

    errors.add(:start_time, I18n.t('activerecord.errors.models.reservation.attributes.date.past')) if start_time < Time.now
    errors.add(:end_time, I18n.t('activerecord.errors.models.reservation.attributes.date.start_time')) if end_time.present? && end_time < start_time
  end

  private

  def bigger(time_a, time_b)
    time_a.to_formatted_s(:time) > time_b.to_formatted_s(:time)
  end

  def check_cancellation
    MakersMailer.cancellation_email(self).deliver if (cancelled? || rejected?)
  end
end
