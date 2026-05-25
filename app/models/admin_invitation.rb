class AdminInvitation < ApplicationRecord
  belongs_to :invited_by, class_name: "User"

  before_validation :assign_token, on: :create
  before_validation :assign_expiry, on: :create

  validates :email, :role, :token, :expires_at, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, inclusion: { in: User::ROLES - ["customer"] }
  validates :token, uniqueness: true

  def active?
    accepted_at.blank? && expires_at.future?
  end

  private

  def assign_token
    self.token ||= SecureRandom.urlsafe_base64(24)
  end

  def assign_expiry
    self.expires_at ||= 7.days.from_now
  end
end
