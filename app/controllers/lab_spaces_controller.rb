class LabSpacesController < ApplicationController
  before_action :set_parent_lab
  before_action :set_lab_space, only: [:show, :edit, :update, :destroy]

  # GET /lab/1/lab_spaces
  # GET /lab/1/lab_spaces.json
  def index
    # @lab_spaces defined in before actions
  end

  # GET /lab/1/lab_spaces/1
  # GET /lab/1/lab_spaces/1.json
  def show
  end

  # GET /lab/1/lab_spaces/new
  def new
    @lab_space = @lab_spaces.new
  end

  # GET /lab/1/lab_spaces/1/edit
  def edit
  end

  # POST /lab/1/lab_spaces
  # POST /lab/1/lab_spaces.json
  def create
    @lab_space = @lab_spaces.new(lab_space_params.merge(creator_param))

    respond_to do |format|
      if @lab_space.save
        format.html { redirect_to [@lab, @lab_space], notice: 'Lab space was successfully created.' }
        format.json { render :show, status: :created, location: @lab_space }
      else
        format.html { render :new }
        format.json { render json: @lab_space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lab/1/lab_spaces/1
  # PATCH/PUT /lab/1/lab_spaces/1.json
  def update
    respond_to do |format|
      if @lab_space.update(lab_space_params)
        format.html { redirect_to [@lab, @lab_space], notice: 'Lab space was successfully updated.' }
        format.json { render :show, status: :ok, location: [@lab, @lab_space] }
      else
        format.html { render :edit }
        format.json { render json: @lab_space.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lab/1/lab_spaces/1
  # DELETE /lab/1/lab_spaces/1.json
  def destroy
    @lab_space.destroy
    respond_to do |format|
      format.html { redirect_to lab_lab_spaces_url(@lab), notice: 'Lab space was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_parent_lab
    @lab = Lab.find(params[:lab_id])
    @lab_spaces = @lab.lab_spaces
  end

  def set_lab_space
    @lab_space = @lab_spaces.find(params[:id])
  end

  def lab_space_params
    params.require(:lab_space).permit(:name, :description, :hours, :location, :contact_email, :contact_phone, :image)
  end

  def creator_param
    {
      creator: current_user
    }
end
