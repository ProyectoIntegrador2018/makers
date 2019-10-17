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

  def get_queried_items
    type = params[:type]
    type_is_capability = type == 'capabilities'
    type_table = type_is_capability ? Capability : Material
    selected_item = params[:selectedItem]
    # Check if an item of the other category was chosen
    if selected_item.present?
      # Define some variables
      other_type = type_is_capability ? 'materials' : 'capabilities'
      type_id = type.singularize + '_id'
      other_type_id = other_type.singularize + '_id'
      equipment_type_table = type_is_capability ? EquipmentCapability : EquipmentMaterial
      other_equipment_type_table = type_is_capability ? EquipmentMaterial : EquipmentCapability

      # Get equipment ids that use the selected item
      equipments = other_equipment_type_table.select(:equipment_id).where("#{other_type_id} = ?", selected_item).map(&:equipment_id)
      # Get the desired items of the equipments selected
      item_ids = equipment_type_table.select(type_id).where(equipment_id: equipments).map{ |item| item[type_id] }
      # Get the name of the items selected
      results = type_table.select(:id, :name).where(id: item_ids)
    else
      # Get all the results
      results = type_table.select(:id, :name)
    end

    query = params[:query]
    if query.present?
      # Filter results by query written
      results = results.where('name ILIKE ?', "%#{query}%").as_json
    end
    return results
  end

  def related
    type = params[:type]

    if type != 'capabilities' && type != 'materials'
      capabilities = Capability.select(:id, :name).as_json
      materials = Material.select(:id, :name).as_json
    else
      results = get_queried_items
    end

    respond_to do |format|
      format.json {
        render json: {
        results: results,
        capabilities: capabilities,
        materials: materials
      }
    }
    end
  end
end
