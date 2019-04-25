class LabSpacePolicy < ManagedModelsPolicy
  def new?
    return false unless user

    user.superadmin? || user.admin?
  end

  def create?
    return false unless user

    user.superadmin? || user.manages?(record.lab)
  end

  class Scope < Scope
    def resolve_admin
      user.managed_lab_spaces
    end
  end
end
