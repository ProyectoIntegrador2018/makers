class EquipmentController < ApplicationController
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]

  # GET /equipment
  # GET /equipment.json
  def index
    @equipment = Equipment.all
  end

  # GET /equipment/1
  # GET /equipment/1.json
  def show
  end

  # GET /equipment/new
  def new
    @equipment = Equipment.new
    @materials = Material.new
    @capabilities = Capability.new
  end

  # GET /equipment/1/edit
  def edit
  end

  # POST /equipment
  # POST /equipment.json
  def create
    @equipment = Equipment.new(equipment_params)

    respond_to do |format|
      if @equipment.save && save_materials && save_capabilities
        format.html { redirect_to @equipment, notice: 'Equipment was successfully created.' }
        format.json { render :show, status: :created, location: @equipment }
      else
        format.html { render :new }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment/1
  # PATCH/PUT /equipment/1.json
  def update
    respond_to do |format|
      if @equipment.update(equipment_params)
        format.html { redirect_to @equipment, notice: 'Equipment was successfully updated.' }
        format.json { render :show, status: :ok, location: @equipment }
      else
        format.html { render :edit }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment/1
  # DELETE /equipment/1.json
  def destroy
    @equipment.destroy
    respond_to do |format|
      format.html { redirect_to equipment_index_url, notice: 'Equipment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_equipment
    @equipment = Equipment.find(params[:id])
  end

  def equipment_params
    params.require(:equipment).permit(:name, :description, :image)
  end

  def materials_params
    params.require(:equipment).permit(:materials)
  end

  def capabilities_params
    params.require(:equipment).permit(:capabilities)
  end

  def save_materials
    if materials_params[:materials]
      materials_params[:materials].split(',').each do |material_name|
        unless material_name.empty?
          material = Material.find_or_create_by(name: material_name)
          equipment_material = EquipmentMaterial.find_or_create_by(
              material: material,
              equipment: @equipment
            )
        end
      end
    end
    true
  end

  def save_capabilities
    if capabilities_params[:capabilities]
      capabilities_params[:capabilities].split(',').each do |capability_name|
        unless capability_name.empty?
          capability = Capability.find_or_create_by(name: capability_name)
          equipment_capability = EquipmentCapability.find_or_create_by(
            capability: capability,
            equipment: @equipment
          )
        end
      end
    end
    true
  end
end
