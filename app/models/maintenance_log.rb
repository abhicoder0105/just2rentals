class MaintenanceLog < ApplicationRecord
  belongs_to :vehicle

  STATUSES = ["Scheduled", "In service", "Completed", "Overdue"].freeze

  validates :status, :service_type, :scheduled_on, presence: true
  validates :status, inclusion: { in: STATUSES }
end
