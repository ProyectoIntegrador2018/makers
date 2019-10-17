# Home controller for static views
class HomeController < ApplicationController
  config.cache_store = :null_store
  before_action :authenticate_user!, except: [:landing, :related]

  def landing
    @body_class = 'Home'
    render layout: false
  end

  def profile
    @reservations = current_user.reservations.confirmed.future
  end

  def queried_items
    # Define some variables
    if params[:type] == 'capabilities'
      other_type = 'materials'
      type_table = Capability
      equipment_type_table = EquipmentCapability
      other_equipment_type_table = EquipmentMaterial
    else
      other_type = 'capabilities'
      type_table = Material
      equipment_type_table = EquipmentMaterial
      other_equipment_type_table = EquipmentCapability
    end
    type_id = type.singularize + '_id'
    other_type_id = other_type.singularize + '_id'
    selected_item = params[:selectedItem]

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
    return results
  end

  def related
    type = params[:type]

    if type != 'capabilities' && type != 'materials'
      capabilities = Capability.select(:id, :name).as_json
      materials = Material.select(:id, :name).as_json
    else
      results = queried_items
      query = params[:query]
      if query.present?
        # Filter results by query written
        results = results.where('name ILIKE ?', "%#{query}%").as_json
      end
    end

    respond_to do |format|
      format.json do
        render json: {
          results: results,
          capabilities: capabilities,
          materials: materials
        }
      end
    end
  end
end
