class TagAssociationsPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    false
  end

  def new?
    return false unless user

    user.superadmin? || user.lab_admin?
  end

  def update?
    false
  end

  def default_authorization
    return false unless user
    return false if user.user?

    user.superadmin? || user.manages?(record.equipment)
  end
end
