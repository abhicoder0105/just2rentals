class Lead < ApplicationRecord
  STATUSES = ["New", "Contacted", "Qualified", "Follow up", "Managed", "Lost"].freeze
  PRIORITIES = ["Low", "Medium", "High", "Urgent"].freeze
  SOURCES = ["Website", "Phone", "WhatsApp", "Walk-in", "Referral", "Campaign"].freeze

  validates :name, :phone, :trip_location, :status, :priority, presence: true
  validates :email, allow_blank: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :status, inclusion: { in: STATUSES }
  validates :priority, inclusion: { in: PRIORITIES }

  scope :pipeline_order, -> { order(Arel.sql("CASE status WHEN 'New' THEN 1 WHEN 'Contacted' THEN 2 WHEN 'Qualified' THEN 3 WHEN 'Follow up' THEN 4 WHEN 'Managed' THEN 5 ELSE 6 END"), follow_up_on: :asc) }
end
