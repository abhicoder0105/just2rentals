class HomeController < ApplicationController
  def index
    @featured_vehicles = Vehicle.featured.limit(4)
    @locations = Vehicle::LOCATIONS
    @categories = Vehicle::CATEGORIES
  end
end
