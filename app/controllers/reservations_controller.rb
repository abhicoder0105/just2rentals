class ReservationsController < ApplicationController
  def new
    @vehicle = Vehicle.find(params[:vehicle_id])
    @reservation = @vehicle.reservations.new(reservation_defaults)
  end

  def create
    @vehicle = Vehicle.find(params[:vehicle_id])
    @reservation = @vehicle.reservations.new(reservation_params.merge(user: current_user))

    if @reservation.save
      redirect_to reservation_path(@reservation.confirmation_code), notice: "Your reservation is confirmed."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @reservation = Reservation.find_by!(confirmation_code: params[:id])
  end

  def lookup
  end

  def find
    @reservation = Reservation.find_by(confirmation_code: params[:confirmation_code].to_s.strip.upcase)

    if @reservation
      redirect_to reservation_path(@reservation.confirmation_code)
    else
      redirect_to lookup_reservations_path, alert: "We could not find that confirmation code."
    end
  end

  private

  def reservation_defaults
    {
      pickup_location: params[:pickup_location].presence || @vehicle.location,
      dropoff_location: params[:dropoff_location].presence || @vehicle.location,
      pickup_date: params[:pickup_date].presence || Date.current + 1.day,
      dropoff_date: params[:dropoff_date].presence || Date.current + 4.days,
      pickup_time: params[:pickup_time].presence || "10:00",
      dropoff_time: params[:dropoff_time].presence || "10:00",
      driver_age: params[:driver_age].presence || 28,
      protection_plan: "Plus"
    }
  end

  def reservation_params
    params.require(:reservation).permit(
      :first_name, :last_name, :email, :phone, :pickup_location, :dropoff_location,
      :pickup_date, :dropoff_date, :pickup_time, :dropoff_time, :driver_age,
      :protection_plan, :notes, extras: []
    )
  end
end
