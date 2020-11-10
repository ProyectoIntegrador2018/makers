class EquipmentController < ApplicationController
  before_action :set_parent_lab_space
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action { authorize(@equipment || @equipment_scope.new) }

  # GET /lab/1/lab_spaces/1/equipment
  # GET /equipment.json
  def index
    @equipment_scope = @equipment_scope.search_by(:materials, params[:materials_query])
    @equipment_scope = @equipment_scope.search_by(:capabilities, params[:capabilities_query])
  end

  # GET /lab/1/lab_spaces/1/equipment/1
  # GET /lab/1/lab_spaces/1/equipment/1.json
  def show
    redirect_to root_path if @equipment.hidden
  end

  # GET /lab/1/lab_spaces/1/equipment/new
  def new
    @equipment = @equipment_scope.new
    @materials = Material.new
    @capabilities = Capability.new
  end

  # GET /lab/1/lab_spaces/1/equipment/1/edit
  def edit
  end

  # POST /lab/1/lab_spaces/1/equipment
  # POST /lab/1/lab_spaces/1/equipment.json
  def create
    @equipment = @equipment_scope.new(equipment_params)
    respond_to do |format|
      if @equipment.save && save_availability
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
      if @equipment.update(equipment_params) && update_availability
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
      @equipment_scope = @lab_space.equipment.visible
    else
      @equipment_scope = Equipment.all.visible
    end
  end

  def set_equipment
    @equipment = @equipment_scope.find(params[:id])
  end

  def equipment_params
    params[:equipment][:material_ids] = Equipment.check_for_new_tags(params[:equipment][:material_ids] || [], :material)
    params[:equipment][:capability_ids] = Equipment.check_for_new_tags(params[:equipment][:capability_ids] || [], :capability)
    params.require(:equipment).permit(:name, :description, :image, :technical_description, :max_usage, :rest_time, capability_ids: [], material_ids: [])
  end

  def schedule_params(schedule)
    { start_time: schedule[:start_time], end_time: schedule[:end_time], day_of_week: schedule[:day_of_week] }
  end

  def save_availability
    available_hours = params[:equipment][:available_hours]
    return true unless available_hours

    result = true
    available_hours.each_pair do |_, schedule|
      availabilities = @equipment.available_hours.new(schedule_params(schedule))
      result &&= availabilities.save
    end

    result
  end

  def update_availability
    @equipment.available_hours.destroy_all
    save_availability
  end
end
