module EquipmentHelper
  def current_user_admin?
    return false unless user_signed_in?

    policy(@lab_space.equipment.new).block?
  end

  def reservation_visible?(res)
    if res.status == 'pending'
      user_signed_in? && (current_user.id == res.user_id || current_user_admin?)
    else
      res.status != 'cancelled' && res.status != 'rejected'
    end
  end

  def reservation_title(res)
    return 'Reservación' unless user_signed_in?

    u = User.find_by_id(res.user_id)
    title = "#{u.given_name} #{u.last_name}"
    if res.status == 'pending'
      title += ' (pendiente)'
    elsif res.status == 'blocked'
      title += ' (bloqueado)'
    end
    title
  end

  def reservation_color(res_purpose, res_status)
    return '#e74c3c' if res_status == 'blocked'

    opacityMap = { 'confirmed' => '.75', 'pending' => '.25' }

    case res_purpose
    when 'academic'
      "rgba(220, 57, 18, #{opacityMap[res_status]})"
    when 'entrepreneurship'
      "rgba(255, 153, 0, #{opacityMap[res_status]})"
    when 'research'
      "rgba(16, 150, 24, #{opacityMap[res_status]})"
    when 'personal'
      "rgba(153, 0, 153, #{opacityMap[res_status]})"
    end
  end

  def reservation_text(reservation_purpose)
    case reservation_purpose
    when 'confirmed'
      '#fefefe'
    when 'pending'
      '#000000'
    when 'blocked'
      '#000000'
    end
  end
end
