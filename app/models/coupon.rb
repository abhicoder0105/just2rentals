class Coupon < ApplicationRecord
  DISCOUNT_TYPES = ["percent", "fixed"].freeze

  has_many :reservations, dependent: :nullify

  validates :code, :discount_type, :value, presence: true
  validates :code, uniqueness: true
  validates :discount_type, inclusion: { in: DISCOUNT_TYPES }
  validates :value, numericality: { greater_than: 0 }

  def available?
    active? &&
      (starts_on.blank? || starts_on <= Date.current) &&
      (ends_on.blank? || ends_on >= Date.current) &&
      (usage_limit.to_i.zero? || used_count.to_i < usage_limit.to_i)
  end

  def discount_for(amount)
    return 0 unless available?

    discount_type == "percent" ? amount * (value / 100) : value
  end
end
