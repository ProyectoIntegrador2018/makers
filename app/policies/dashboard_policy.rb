class DashboardPolicy
  attr_reader :user, :record

  def initialize(user, dashboard)
    @user = user
    @record = dashboard
  end

  def users?
    true
  end

  def available_hours?
    true
  end

  def capabilities?
    true
  end

  def equipment?
    true
  end

  def equipment_capabilities?
    false
  end

  def equipment_materials?
    false
  end

  def labs?
    user.superadmin? || user.admin? || user.managed_labs.count > 0
  end

  def lab_spaces?
    true
  end

  def materials?
    true
  end

  def reservations?
    true
  end

  def lab_administrations?
    user.superadmin? || user.admin?
  end
end
