module Admin
  class VehiclesController < BaseController
    before_action -> { require_permission!("fleet.manage") }
    before_action :set_vehicle, only: [:edit, :update, :destroy]

    def index
      @vehicles = Vehicle.order(created_at: :desc)
    end

    def new
      @vehicle = Vehicle.new(available: true)
    end

    def create
      @vehicle = Vehicle.new(vehicle_params)
      if @vehicle.save
        redirect_to admin_vehicles_path, notice: "Car listing created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @vehicle.update(vehicle_params)
        redirect_to admin_vehicles_path, notice: "Car listing updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @vehicle.destroy
      redirect_to admin_vehicles_path, notice: "Car listing removed."
    end

    private

    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    def vehicle_params
      params.require(:vehicle).permit(:name, :make, :model, :year, :category, :seats, :doors, :transmission, :fuel,
                                      :drivetrain, :location, :daily_rate, :rating, :image_url, :hero_color,
                                      :mileage, :luggage, :featured, :available, :description)
    end
  end
end
