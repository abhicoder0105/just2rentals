class ContentBlock < ApplicationRecord
  validates :key, :title, :placement, presence: true
  validates :key, uniqueness: true
end
