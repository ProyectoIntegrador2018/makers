module ReservationsHelper

  def help_needed_spanish?(help_needed)
    return "Si" if help_needed
    return "No"
  end
end
