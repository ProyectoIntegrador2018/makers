class ReservationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    default_authorization
  end

  def create?
    default_authorization
  end

  def update?
    default_authorization
  end

  def destroy?
    default_authorization
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
      return user.directly_managed_reservations if user.admin?
      return user.indirectly_managed_reservations if user.lab_admin?

      user.reservations
    end
  end
end
