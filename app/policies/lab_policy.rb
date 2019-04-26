class LabPolicy < ManagedModelsPolicy
  def create?
    return false unless user
    return false if user.user?

    user.superadmin? || user.admin?
  end

  class Scope < Scope
    def alternative_admin_scope
      user.managed_labs
    end
  end
end
