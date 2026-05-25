class SupportTicket < ApplicationRecord
  belongs_to :user
  belongs_to :reservation, optional: true

  STATUSES = ["Open", "Waiting", "Resolved", "Closed"].freeze
  PRIORITIES = ["Low", "Medium", "High", "Urgent"].freeze

  validates :subject, :status, :priority, :message, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :priority, inclusion: { in: PRIORITIES }
end
