class Vehicle < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :maintenance_logs, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy

  CATEGORIES = ["Economy", "Compact", "SUV", "Luxury", "Electric", "Van"].freeze
  TRANSMISSIONS = ["Automatic", "Manual"].freeze
  FUELS = ["Petrol", "Diesel", "Hybrid", "Electric"].freeze
  LOCATIONS = ["Delhi Airport", "Gurugram Cyber City", "Mumbai Airport", "Bengaluru Indiranagar", "Goa Panaji"].freeze

  validates :name, :make, :model, :category, :location, :daily_rate, presence: true
  validates :daily_rate, numericality: { greater_than: 0 }
  validates :seats, :doors, :luggage, numericality: { only_integer: true, greater_than: 0 }

  scope :available, -> { where(available: true) }
  scope :featured, -> { where(featured: true) }

  def self.search(filters)
    vehicles = available.order(featured: :desc, daily_rate: :asc)
    vehicles = vehicles.where(location: filters[:location]) if filters[:location].present?
    vehicles = vehicles.where(category: filters[:category]) if filters[:category].present?
    vehicles = vehicles.where(transmission: filters[:transmission]) if filters[:transmission].present?
    vehicles = vehicles.where(fuel: filters[:fuel]) if filters[:fuel].present?
    vehicles = vehicles.where("seats >= ?", filters[:seats].to_i) if filters[:seats].present?
    vehicles = vehicles.where("daily_rate <= ?", filters[:max_rate].to_d) if filters[:max_rate].present?
    vehicles
  end

  def badge_text
    featured? ? "Most booked" : category
  end

  def utilization_percent
    booked_days = reservations.where(status: ["approved", "active", "completed"]).sum { |reservation| reservation.rental_days }
    [(booked_days / 30.0 * 100).round, 100].min
  end
end
