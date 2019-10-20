# Home controller for static views
class HomeController < ApplicationController
  config.cache_store = :null_store
  before_action :authenticate_user!, except: [:landing, :related, :equipment_relation]

  def landing
    @body_class = 'Home'
    render layout: false
  end

  def profile
    @reservations = current_user.reservations.confirmed.future
  end

  def apply_query(options = {})
    # Define some variables
    type_id = params[:type].singularize + '_id'
    selected_item = params[:selectedItem]
    # Get all the results
    results = options[:type_table].select(:id, :name)
    # Check if an item of the other category was chosen
    if selected_item.present?
      # Get equipment ids that use the selected item
      equipments = options[:other_equipment_type_table].select(:equipment_id).where("#{options[:other_type_id]} = ?", selected_item).map(&:equipment_id)
      # Get the desired items of the equipments selected
      item_ids = options[:equipment_type_table].select(type_id).where(equipment_id: equipments).map { |item| item[type_id] }
      # Get the name of the items selected
      results = results.where(id: item_ids)
    end
    results
  end

  def queried_items
    if params[:type] == 'capabilities'
      apply_query(type_table: Capability, equipment_type_table: EquipmentCapability, other_equipment_type_table: EquipmentMaterial, other_type_id: 'material_id')
    else
      apply_query(type_table: Material, equipment_type_table: EquipmentMaterial, other_equipment_type_table: EquipmentCapability, other_type_id: 'capability_id')
    end
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

  def equipment_relation
    equipments_capabilities = EquipmentCapability.select(:equipment_id).where(capability_id: params[:capability]).map(&:equipment_id)
    equipments_materials = EquipmentMaterial.select(:equipment_id).where(material_id: params[:material]).map(&:equipment_id)
    respond_to do |format|
      format.json do
        render json: {
          are_related: !(equipments_capabilities & equipments_materials).empty?
        }
      end
    end
  end
end
