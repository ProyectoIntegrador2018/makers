# Home controller for static views
class HomeController < ApplicationController
  config.cache_store = :null_store
  before_action :authenticate_user!, except: [:landing, :capabilities, :materials]

  def landing
    @body_class = 'Home'
    render layout: false
  end

  def profile
    @reservations = current_user.reservations.confirmed.future
  end

  def capabilities
    # Check if an item of the other category was chosen
    if params[:selectedItem].present?
      # Get equipment ids that use the selected material
      equipments = EquipmentMaterial.select(:equipment_id).where(material_id: params[:selectedItem]).map(&:equipment_id)
      # Get the capabilities of the equipments selected
      capabilities = EquipmentCapability.select(:capability_id).where(equipment_id: equipments).map(&:capability_id)
      # Get the name of the capabilities selected
      @capabilities = Capability.select(:id, :name).where(id: capabilities)
    else
      # Get all the capabilities
      @capabilities = Capability.select(:id, :name)
    end
    if params[:query].present?
      # Filter capabilities by query written
      @capabilities = @capabilities.select(:id, :name).where("name ILIKE ?", "%#{params[:query]}%").as_json()
    end
    if request.xhr?
      respond_to do |format|
        format.json {
          render json: {results: @capabilities}
        }
      end
    end
  end

  def materials
    # Check if an item of the other category was chosen
    if params[:selectedItem].present?
      # Get equipment ids that use the selected capability
      equipments = EquipmentCapability.select(:equipment_id).where(capability_id: params[:selectedItem]).map(&:equipment_id)
      # Get the materials of the equipments selected
      materials = EquipmentMaterial.select(:material_id).where(equipment_id: equipments).map(&:material_id)
      # Get the name of the capabilities selected
      @materials = Material.select(:id, :name).where(id: materials)
    else
      # Get all the capabilities
      @materials = Material.select(:id, :name)
    end
    if params[:query].present?
      # Filter capabilities by query written
      @materials = @materials.select(:id, :name).where("name ILIKE ?", "%#{params[:query]}%").as_json()
    end
    if request.xhr?
      respond_to do |format|
        format.json {
          render json: {results: @materials}
        }
      end
    end
  end

end
