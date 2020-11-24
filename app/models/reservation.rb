class Reservation < ApplicationRecord
  enum status: [:confirmed, :pending, :rejected, :cancelled, :blocked]
  enum purpose: [:academic, :entrepreneurship, :research, :personal]

  belongs_to :equipment, counter_cache: true
  belongs_to :user, optional: true

  validates :status, :purpose, :start_time, :end_time, presence: true
  validate :date_range_valid, :not_overlapped, if: -> { start_time_changed? || end_time_changed? }
  validate :is_available, on: :create
  validate :equipment_rules, on: :create, unless: Proc.new { self.status == "blocked"}

  scope :upcoming, ->(limit) { where('start_time > ?', Time.current).order(:start_time).limit(limit) }
  scope :future, -> { where('start_time > ?', Time.current).order(:start_time) }

  after_save :rest_time_reservation, unless: Proc.new { self.status == "blocked"}
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
             .where.not('status = ? OR status = ?', statuses[:cancelled], statuses[:rejected])
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

  # Checks if the the reservation surpases the total allowed time
  def max_usage_time(current_time, max_usage)
    statuses = Reservation.statuses
    start_time = (current_time.to_time - max_usage.hours).to_datetime
    active_reservations = equipment.reservations
                                    .where('start_time >= ? AND start_time < ?', start_time, current_time)
                                    .where('status = ?', statuses[:confirmed])
    used_time = active_reservations.sum { |res| ((res.end_time - res.start_time) / 3600) }
    used_time
  end

  def equipment_rules
    # Checks equiment rules and reject the creation in case it breaks them
    duration = ((self.end_time - self.start_time) / 3600)
    used_time = max_usage_time(self.start_time, self.equipment.rest_time)
    if ((duration + used_time) > self.equipment.max_usage.to_f)
      errors.add(:end_time, I18n.t('activerecord.errors.models.reservation.attributes.date.max_usage'))
    end
  end

  def rest_time_reservation
    # Creates a blocked reservation in case max usage has been reached
    duration = (self.status == "confirmed"? ((self.end_time - self.start_time) / 3600) : 0.0)
    used_time = max_usage_time(self.start_time, self.equipment.max_usage)
    user_id = self.equipment.lab_space.user.nil? ? User.first.id : self.equipment.lab_space.user.id
    if((duration + used_time) >= self.equipment.max_usage.to_f)
      end_rest = (self.end_time + self.equipment.rest_time.hours).to_datetime
      new_reservation = Reservation.new(status: "blocked", comment: "Bloquear reservas del equipo para evitar perdida en rendimiento",
                                        start_time: self.end_time, end_time: end_rest, equipment_id: self.equipment.id,
                                        updated_at: Time.now, user_id: user_id)
      new_reservation.save
    end
  end

  def check_status
    MakersMailer.status_email(self).deliver_now if not blocked?
  end
end
