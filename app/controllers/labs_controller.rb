class LabsController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update, :destroy]
  before_action :check_if_valid_user, only: [:edit, :update, :destroy]
  before_action :check_if_super_admin, only: [:new]

  # GET /labs
  # GET /labs.json
  def index
    @labs = Lab.all
  end

  # GET /labs/1
  # GET /labs/1.json
  def show
    @capabilities = Capability.all
    @materials = Material.all
  end

  # GET /labs/new
  def new
    @lab = Lab.new
  end

  # GET /labs/1/edit
  def edit
  end

  # POST /labs
  # POST /labs.json
  def create
    @lab = Lab.new(lab_params)

    respond_to do |format|
      if @lab.save
        format.html { redirect_to @lab, notice: 'Lab was successfully created.' }
        format.json { render :show, status: :created, location: @lab }
      else
        format.html { render :new }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /labs/1
  # PATCH/PUT /labs/1.json
  def update
    respond_to do |format|
      if @lab.update(lab_params)
        format.html { redirect_to @lab, notice: 'Lab was successfully updated.' }
        format.json { render :show, status: :ok, location: @lab }
      else
        format.html { render :edit }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labs/1
  # DELETE /labs/1.json
  def destroy
    @lab.destroy
    respond_to do |format|
      format.html { redirect_to labs_url, notice: 'Lab was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_lab
    @lab = Lab.find(params[:id])
  end

  def check_if_super_admin
    return unless user_signed_in? && current_user.role == 'superadmin'
    flash[:error] = 'You must be a super admin to access this section'
    redirect_to root_path # halts request cycle
  end

  def check_if_valid_user
    return unless user_signed_in? && (current_user.role == 'superadmin' || (current_user.role == 'lab_admin' && current_user.id == @lab.user.id))
    flash[:error] = 'You must be a super admin to access this section'
    redirect_to root_path # halts request cycle
  end

  def lab_params
    params.require(:lab).permit(:name, :description, :location, :image, :user_id, :location_link)
  end
end
