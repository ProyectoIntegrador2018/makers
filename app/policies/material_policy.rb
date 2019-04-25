class MaterialPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def destroy?
    false
  end

  def update?
    false
  end

  def default_authorization
    return false unless user
    user.superadmin? || user.admin? || user.lab_admin?
  end
end
