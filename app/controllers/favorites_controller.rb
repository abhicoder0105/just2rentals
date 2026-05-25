class FavoritesController < ApplicationController
  before_action :require_customer!

  def create
    vehicle = Vehicle.find(params[:vehicle_id])
    current_user.favorites.find_or_create_by!(vehicle: vehicle)
    redirect_back fallback_location: vehicles_path, notice: "Added to wishlist."
  end

  def destroy
    current_user.favorites.find_by!(vehicle_id: params[:vehicle_id]).destroy
    redirect_back fallback_location: account_path, notice: "Removed from wishlist."
  end
end
