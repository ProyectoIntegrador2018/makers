module HomeHelper
  def apply_caps_mats_query(type, selected_item)
    if type == 'capabilities'
      type_table = Capability
      equipment_type_table = EquipmentCapability
      other_equipment_type_table = EquipmentMaterial
      other_type_id = 'material_id'
    else
      type_table = Material
      equipment_type_table = EquipmentMaterial
      other_equipment_type_table = EquipmentCapability
      other_type_id = 'capability_id'
    end
    # Define some variables
    type_id = type.singularize + '_id'
    # Get all the results
    results = type_table.select(:id, :name)
    # Check if an item of the other category was chosen
    if selected_item.present?
      # Get equipment ids that use the selected item
      equipments = other_equipment_type_table.select(:equipment_id).where("#{other_type_id} = ?", selected_item).map(&:equipment_id)
      # Get the desired items of the equipments selected
      item_ids = equipment_type_table.select(type_id).where(equipment_id: equipments).map { |item| item[type_id] }
      # Get the name of the items selected
      results = results.where(id: item_ids)
    end
    results
  end

  def materials_and_capabilities_relations
    materials = {}
    capabilities = {}
    Material.all.each do |mat|
      mat_caps = mat.equipment.capabilities.pluck(:name).uniq
      materials[mat.name] = mat_caps
      mat_caps.each do |cap|
        if capabilities.has_key? cap
          capabilities[cap] |= [mat.name]
        else
          capabilities[cap] = [mat.name]
        end
      end
    end
    return materials, capabilities
  end
end
