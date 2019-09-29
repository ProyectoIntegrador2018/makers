class AvailableHourPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def default_authorization
    return false unless user
    return user.manages?(record.equipment) if user.superadmin? || user.lab_admin?

    user.superadmin?
  end
end
