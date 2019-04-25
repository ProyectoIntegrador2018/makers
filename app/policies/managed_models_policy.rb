class ManagedModelsPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    return false unless user
    user.superadmin? || user.admin? || user.lab_admin?
  end

  def default_authorization
    return false unless user
    return user.manages?(record) if user.admin? || user.lab_admin?
    user.superadmin?
  end
end
