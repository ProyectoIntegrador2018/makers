class ManagedModelsPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def default_authorization
    return false unless user
    return user.manages?(record) if user.lab_space_admin? || user.lab_admin?

    user.superadmin?
  end
end
