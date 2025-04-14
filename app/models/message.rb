class Message < ApplicationRecord
  validates :content, presence: true
  belongs_to :room
  belongs_to :user
  has_one_attached :image
end
