class RentalDocument < ApplicationRecord
  belongs_to :reservation

  STATUSES = ["Pending review", "Accepted", "Rejected", "Needs resubmission"].freeze
  TYPES = ["Driving license", "Aadhaar / ID proof", "Address proof", "Payment receipt"].freeze

  validates :document_type, :file_name, :status, presence: true
  validates :status, inclusion: { in: STATUSES }
end
