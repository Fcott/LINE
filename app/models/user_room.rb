class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :messages
  validates :user, presence: true
  validates :room, presence: true
  validates :user_id, uniqueness: { scope: :room_id }
end