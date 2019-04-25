class LabPolicy < ManagedModelsPolicy
  class Scope < Scope
    def resolve_admin
      user.managed_labs
    end
  end
end
