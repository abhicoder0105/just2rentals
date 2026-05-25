class AccountController < ApplicationController
  before_action :require_customer!

  def show
    @reservations = current_user.reservations.includes(:vehicle).order(created_at: :desc)
    @favorites = current_user.favorite_vehicles.order(:name)
  end
end
