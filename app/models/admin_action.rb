class AdminAction < ApplicationRecord
  belongs_to :user

  serialize :metadata, coder: JSON

  validates :action, presence: true
end
