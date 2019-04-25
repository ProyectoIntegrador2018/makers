class LabSpacePolicy < ManagedModelsPolicy
  class Scope < Scope
    def resolve_admin
      user.managed_lab_spaces
    end
  end
end
