class User < ApplicationRecord
  has_secure_password

  ROLES = ["customer", "support_agent", "fleet_manager", "admin", "super_admin"].freeze

  has_many :reservations, dependent: :nullify
  has_many :payments, dependent: :nullify
  has_many :favorites, dependent: :destroy
  has_many :favorite_vehicles, through: :favorites, source: :vehicle
  has_many :support_tickets, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :admin_actions, dependent: :destroy
  has_many :user_permissions, dependent: :destroy
  has_many :permissions, through: :user_permissions
  has_many :sent_admin_invitations, class_name: "AdminInvitation", foreign_key: :invited_by_id, dependent: :nullify

  normalizes :email, with: ->(email) { email.to_s.strip.downcase }

  validates :name, :email, :role, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, inclusion: { in: ROLES }

  def customer?
    role == "customer"
  end

  def admin?
    role == "admin"
  end

  def support_agent?
    role == "support_agent"
  end

  def fleet_manager?
    role == "fleet_manager"
  end

  def super_admin?
    role == "super_admin"
  end

  def admin_access?
    active? && !customer?
  end

  def can?(permission_key)
    return true if super_admin?

    permissions.exists?(key: permission_key)
  end
end
