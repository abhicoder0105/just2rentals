class Payment < ApplicationRecord
  belongs_to :reservation
  belongs_to :user, optional: true

  STATUSES = ["Pending", "Paid", "Failed", "Refunded"].freeze

  validates :amount, :status, :provider, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: STATUSES }
end
