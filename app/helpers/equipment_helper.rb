module EquipmentHelper
  def filter_reservations_for_user(reservations)
    viable_reservations = reservations.confirmed.or(reservations.blocked).or(reservations.pending)
    viable_reservations.select do |res|
      if (res.status == "pending")
        res.user == current_user
      else
        true
      end
    end
  end

  def set_reservation_title(res)
    if (user_signed_in? && current_user.id == res.user_id)
      title = "#{current_user.given_name} #{current_user.last_name}"
      if (res.status == "pending")
        title = "#{title} (pendiente)"
      end
    else
      title = "Reservación"
    end
    return title
  end

  def set_reservation_color(res)
    if (res.status == "pending")
      '#bdc3c7'
    else
      'rgba(68, 93, 252, .77)'
    end
  end
end
