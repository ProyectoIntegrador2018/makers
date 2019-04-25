class LabAdministrationPolicy < ApplicationPolicy
  def new?
    true
  end

  def update?
    false
  end

  def default_authorization
    return false unless user
    return user.manages?(record.space) if user.admin? || user.lab_admin?
    user.superadmin?
  end

  class Scope < Scope
    def resolve_admin
      user.managed_lab_administrations
    end
  end
end
