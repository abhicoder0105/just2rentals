class VehiclesController < ApplicationController
  def index
    @filters = filter_params
    @vehicles = Vehicle.search(@filters)
    @categories = Vehicle::CATEGORIES
    @locations = Vehicle::LOCATIONS
    @transmissions = Vehicle::TRANSMISSIONS
    @fuels = Vehicle::FUELS
  end

  def show
    @vehicle = Vehicle.find(params[:id])
    @reservation = @vehicle.reservations.new(
      pickup_location: params[:pickup_location].presence || @vehicle.location,
      dropoff_location: params[:dropoff_location].presence || @vehicle.location,
      pickup_date: params[:pickup_date].presence || Date.current + 1.day,
      dropoff_date: params[:dropoff_date].presence || Date.current + 4.days,
      pickup_time: params[:pickup_time].presence || "10:00",
      dropoff_time: params[:dropoff_time].presence || "10:00",
      driver_age: params[:driver_age].presence || 28,
      protection_plan: "Plus"
    )
  end

  private

  def filter_params
    params.permit(:location, :category, :transmission, :fuel, :seats, :max_rate, :pickup_date, :dropoff_date, :driver_age)
  end
end
