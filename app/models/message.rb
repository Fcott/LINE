class Message < ApplicationRecord
  belongs_to :user_room
  validates :content, presence: true
end
