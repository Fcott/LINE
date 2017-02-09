class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :user, presence: true
  validates :room, presence: true
  validates :user_id, uniqueness: { scope: :room_id }
end
