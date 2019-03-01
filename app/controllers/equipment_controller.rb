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
      if @equipment.save && save_relations('materials') && save_relations('capabilities')
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
      if @equipment.update(equipment_params) && update_relations('materials') && update_relations('capabilities')
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
      params.require(:equipment)[type] .split(',').each do |tag_name|
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
