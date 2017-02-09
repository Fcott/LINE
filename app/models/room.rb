class Room < ApplicationRecord
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
  has_many :messages, dependent: :destroy
  before_create :set_default


  private
  def set_default

    self.image ||= "http://d23mdu6au44x93.cloudfront.net/31896-36739-large/-line-friends-official-goods-brown-coaster.jpg"
  end
end
