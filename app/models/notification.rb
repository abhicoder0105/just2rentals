class Notification < ApplicationRecord
  belongs_to :user

  validates :title, :body, :kind, presence: true
end
