class Reservation < ApplicationRecord
  belongs_to :vehicle
  belongs_to :user, optional: true
  belongs_to :coupon, optional: true

  serialize :extras, coder: JSON
  serialize :pricing_snapshot, coder: JSON

  PROTECTION_PLANS = {
    "Essential" => 499,
    "Plus" => 899,
    "Premium" => 1499
  }.freeze

  EXTRA_OPTIONS = {
    "Child seat" => 250,
    "Additional driver" => 450,
    "Airport fast pickup" => 300,
    "Unlimited kilometers" => 999
  }.freeze

  STATUSES = ["pending", "approved", "active", "completed", "cancelled", "rejected"].freeze
  DEPOSIT_STATUSES = ["Pending", "Paid", "Refunded", "Forfeited"].freeze
  DOCUMENT_STATUSES = ["Pending review", "Accepted", "Rejected", "Needs resubmission"].freeze

  before_validation :assign_confirmation_code, on: :create
  before_validation :assign_invoice_number, on: :create
  before_validation :set_defaults
  before_validation :calculate_total

  validates :first_name, :last_name, :email, :phone, :pickup_location, :dropoff_location,
            :pickup_date, :dropoff_date, :pickup_time, :dropoff_time, :driver_age, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :driver_age, numericality: { only_integer: true, greater_than_or_equal_to: 21 }
  validates :status, inclusion: { in: STATUSES }
  validates :deposit_status, inclusion: { in: DEPOSIT_STATUSES }
  validates :document_status, inclusion: { in: DOCUMENT_STATUSES }
  validate :dropoff_after_pickup
  validate :vehicle_available_for_dates

  has_many :rental_documents, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_one :review, dependent: :nullify

  scope :active_overlap, ->(pickup_date, dropoff_date) {
    where(status: ["pending", "approved", "active"])
      .where("pickup_date < ? AND dropoff_date > ?", dropoff_date, pickup_date)
  }

  def renter_name
    [first_name, last_name].join(" ")
  end

  def rental_days
    return 1 unless pickup_date && dropoff_date

    [(dropoff_date - pickup_date).to_i, 1].max
  end

  def cancellable?
    ["pending", "approved"].include?(status)
  end

  private

  def assign_confirmation_code
    self.confirmation_code ||= "J2C#{SecureRandom.alphanumeric(6).upcase}"
  end

  def assign_invoice_number
    self.invoice_number ||= "INV-#{Time.current.strftime('%Y%m')}-#{SecureRandom.alphanumeric(5).upcase}"
  end

  def set_defaults
    self.status ||= "pending"
    self.deposit_status ||= "Pending"
    self.document_status ||= "Pending review"
    self.deposit_amount ||= vehicle ? vehicle.daily_rate : 0
    self.protection_plan = "Essential" if protection_plan.blank?
    self.extras = Array(extras).reject(&:blank?)
  end

  def calculate_total
    return unless vehicle

    protection = PROTECTION_PLANS.fetch(protection_plan, 0)
    extra_total = Array(extras).sum { |extra| EXTRA_OPTIONS.fetch(extra, 0) }
    subtotal = (vehicle.daily_rate * rental_days) + protection + extra_total
    discount = coupon&.discount_for(subtotal).to_d
    self.total_price = subtotal - discount
    self.pricing_snapshot = {
      daily_rate: vehicle.daily_rate.to_s,
      days: rental_days,
      protection: protection,
      extras: Array(extras),
      extra_total: extra_total,
      discount: discount.to_s
    }
  end

  def dropoff_after_pickup
    return if pickup_date.blank? || dropoff_date.blank?

    errors.add(:dropoff_date, "must be after pickup date") if dropoff_date <= pickup_date
  end

  def vehicle_available_for_dates
    return if vehicle.blank? || pickup_date.blank? || dropoff_date.blank?

    conflict = vehicle.reservations.active_overlap(pickup_date, dropoff_date)
    conflict = conflict.where.not(id: id) if persisted?
    errors.add(:base, "Vehicle is already booked for those dates") if conflict.exists?
  end
end
