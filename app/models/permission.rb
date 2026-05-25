class Permission < ApplicationRecord
  validates :key, :category, presence: true
  validates :key, uniqueness: true

  has_many :user_permissions, dependent: :destroy
  has_many :users, through: :user_permissions
end
