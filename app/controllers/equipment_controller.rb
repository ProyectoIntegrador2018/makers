class EquipmentController < ApplicationController
  before_action :set_parent_lab_space
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]

  # GET /lab/1/lab_spaces/1/equipment
  # GET /equipment.json
  def index
    @equipment = @equipment.search(params[:equipment_query])
    @equipment = @equipment.search_by(:materials, params[:materials_query])
    @equipment = @equipment.search_by(:capabilities, params[:capabilities_query])
  end

  # GET /lab/1/lab_spaces/1/equipment/1
  # GET /lab/1/lab_spaces/1/equipment/1.json
  def show
  end

  # GET /lab/1/lab_spaces/1/equipment/new
  def new
    @equipment = @equipment.new
    @materials = Material.new
    @capabilities = Capability.new
  end

  # GET /lab/1/lab_spaces/1/equipment/1/edit
  def edit
  end

  # POST /lab/1/lab_spaces/1/equipment
  # POST /lab/1/lab_spaces/1/equipment.json
  def create
    @equipment = @equipment.new(equipment_params)
    respond_to do |format|
      if @equipment.save && save_relations('materials') && save_relations('capabilities')
        format.html { redirect_to [@lab_space.lab, @lab_space, @equipment], notice: 'Equipment was successfully created.' }
        format.json { render :show, status: :created, location: [@lab_space.lab, @lab_space, @equipment] }
      else
        format.html { render :new }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lab/1/lab_spaces/1/equipment/1
  # PATCH/PUT /lab/1/lab_spaces/1/equipment/1.json
  def update
    respond_to do |format|
      if @equipment.update(equipment_params) && update_relations('materials') && update_relations('capabilities')
        format.html { redirect_to [@lab_space.lab, @lab_space, @equipment], notice: 'Equipment was successfully updated.' }
        format.json { render :show, status: :ok, location: [@lab_space.lab, @lab_space, @equipment] }
      else
        format.html { render :edit }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lab/1/lab_spaces/1/equipment/1
  # DELETE /lab/1/lab_spaces/1/equipment/1.json
  def destroy
    @equipment.destroy
    respond_to do |format|
      format.html { redirect_to lab_lab_space_equipment_index_path, notice: 'Equipment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_parent_lab_space
    if params[:lab_space_id]
      @lab_space = LabSpace.find(params[:lab_space_id])
      @equipment = @lab_space.equipment
      @capabilities = @equipment.map(:capabilities).compact
      @materials = @equipment.map(:materials).compact
    else
      @equipment = Equipment.all
      @capabilities = Capability.all
      @materials = Material.all
    end
  end

  def set_equipment
    @equipment = @equipment.find(params[:id])
  end

  def equipment_params
    params.require(:equipment).permit(:name, :description, :image, :technical_description)
  end

  def update_relations(type)
    @equipment.try(type).clear
    class_type = type.classify.safe_constantize
    class_type.try(:orphaned).try(:destroy_all)
    save_relations(type)
  end

  def save_relations(type)
    tag_class = type.classify.safe_constantize
    relation_class = ('Equipment' + tag_class.name).classify.safe_constantize
    if params.require(:equipment)[type] && tag_class && relation_class
      params.require(:equipment)[type].split(/[,\s]+/).each do |tag_name|
        next if tag_name.empty?

        relation_class.find_or_create_by(
          :equipment => @equipment,
          type.singularize => tag_class.find_or_create_by(name: tag_name)
        )
      end
    end
    true
  end
end
