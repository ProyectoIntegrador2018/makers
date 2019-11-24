module EquipmentHelper
  def filter_reservations_for_user(reservations)
    viable_reservations = reservations.confirmed.or(reservations.blocked).or(reservations.pending)
    viable_reservations.select do |reservation|
      reservation.status == 'pending' ? (reservation.user == current_user) : true
    end
  end

  def reservation_title(res)
    if user_signed_in? && current_user.id == res.user_id
      title = "#{current_user.given_name} #{current_user.last_name}"
      title = "#{title} (pendiente)" if res.status == 'pending'
    else
      title = 'Reservación'
    end
  end

  def reservation_color(res)
    res.status == 'pending' ? '#bdc3c7' : 'rgba(68, 93, 252, .77)'
  end
end
