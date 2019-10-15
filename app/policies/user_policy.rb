class UserPolicy < ApplicationPolicy
  def index?
    return false unless user
    user.superadmin? || user.lab_admin? || user.lab_space_admin?
  end

  def show?
    return false unless user
    user.id == record.id || user.superadmin? || user.lab_admin? || user.lab_space_admin?
  end

  def create?
    user.blank?
  end

  def update?
    return false unless user
    user.id == record.id || user.superadmin? || user.lab_admin?
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
