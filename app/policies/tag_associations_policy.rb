class TagAssociationsPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    false
  end

  def new?
    true
  end

  def update?
    false
  end

  def default_authorization
    return false unless user
    return false if user.user?

    user.manages?(record.equipment)
  end
end
