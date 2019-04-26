class ReservationPolicy < ApplicationPolicy
  def index?
    true
  end

  def default_authorization
    return false unless user
    return true if record.user == user
    return user.manages?(record) if user.admin? || user.lab_admin?

    user.superadmin?
  end

  class Scope < Scope
    def resolve
      return scope.all if user.superadmin?
      return user.managed_reservations if user.admin? || user.lab_admin?

      user.reservations
    end

    def alternative_admin_scope
      user.managed_reservations
    end
  end
end
