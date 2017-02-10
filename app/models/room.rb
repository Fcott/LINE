class Room < ApplicationRecord
  before_create :set_default
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
  has_many :messages, dependent: :destroy

  scope :direct_messages, -> { where(direct: true)  }

  def self.direct_message_for(users)
    user_ids = users.map(&:id).sort
    name = "DM:#{user_ids.join(",")}"

    if room = direct_messages.where(name: name).first
      return room
    else
      room = new(name: name, direct: true)
      room.users = users
      room.save
      return room
    end
  end


  private
  def set_default

    self.image ||= "http://d23mdu6au44x93.cloudfront.net/31896-36739-large/-line-friends-official-goods-brown-coaster.jpg"
  end
end
