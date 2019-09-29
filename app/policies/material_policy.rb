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

    user.superadmin? || user.lab_admin? || user.lab_space_admin? 
  end
end
