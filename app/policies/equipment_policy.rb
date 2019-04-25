class EquipmentPolicy < ManagedModelsPolicy
  class Scope < Scope
    def resolve_admin
      user.managed_equipment
    end
  end
end
