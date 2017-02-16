class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :user, presence: true
  validates :room, presence: true

  def sent_time
    created_at.strftime("%c")
  end

  def self.recent_100
    order(created_at: :desc).limit(100).reverse
  end
end
