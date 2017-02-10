class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :user, presence: true
  validates :room, presence: true

  default_scope -> { order(created_at: :desc) }
end
