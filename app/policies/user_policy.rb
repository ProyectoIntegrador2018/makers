class UserPolicy < ApplicationPolicy
  def index?
    user.superadmin? || user.admin? || user.lab_admin?
  end

  def show?
    user.id == record.id || user.superadmin? || user.admin? || user.lab_admin?
  end

  def create?
    false if user
  end

  def update?
    user.id == record.id || user.superadmin? || user.admin?
  end

  def destroy?
    user.id == record.id || user.superadmin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
