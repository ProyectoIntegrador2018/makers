class DashboardPolicy
  attr_reader :user, :record

  def initialize(user, dashboard)
    @user = user
    @record = dashboard
  end

  def users?
    !user.user?
  end

  def available_hours?
    !user.user?
  end

  def capabilities?
    !user.user?
  end

  def equipment?
    !user.user?
  end

  def equipment_capabilities?
    false
  end

  def equipment_materials?
    false
  end

  def labs?
    user.superadmin? || user.admin? || user.managed_labs.count.positive?
  end

  def lab_spaces?
    !user.user?
  end

  def materials?
    !user.user?
  end

  def reservations?
    !user.user?
  end

  def lab_administrations?
    user.superadmin? || user.admin?
  end
end
