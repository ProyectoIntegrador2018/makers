class ReservationsController < ApplicationControllergit ad
  before_action :authenticate_user!, except: [:index]
  before_action :set_reservations_scope
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /equipment/1/reservations
  # GET /reservations.json
  # GET /equipment/1/reservations.json
  def index
    @reservations = @reservations_scope.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /equipment/1/reservations/new
  def new
    @reservation = @reservations_scope.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /equipment/1//reservations
  # POST /equipment/1//reservations.json
  def create
    @reservation = @reservations_scope.new(reservation_params)
    @reservation.user = current_user

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_reservations_scope
    if params[:equipment_id]
      @reservations_scope = Equipment.find(params[:equipment_id]).reservations
    else
      @reservations_scope = current_user.reservations
    end
  end

  def set_reservation
    @reservation = @reservations_scope.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:status, :purpose, :comment, :start_time, :end_time)
  end
end
