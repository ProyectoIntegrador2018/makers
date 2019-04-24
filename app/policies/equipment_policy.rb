class EquipmentPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def default_authorization
    return false unless user
    return user.manages?(record) if user.admin? || user.lab_admin?
    user.superadmin?
  end
end
