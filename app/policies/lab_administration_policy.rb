class LabAdministrationPolicy < ApplicationPolicy
  def new?
    return false unless user

    user.superadmin? || user.admin?
  end

  def update?
    false
  end

  def default_authorization
    return false unless user
    return user.manages?(record.space) if user.admin?

    user.superadmin?
  end

  class Scope < Scope
    def alternative_admin_scope
      user.managed_lab_administrations
    end
  end
end