class Room < ApplicationRecord
  before_create :set_default
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
  has_many :messages, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :invited_users, through: :invitations, class_name: User

  scope :direct_messages, -> { where(direct: true)  }
  scope :groups, -> { where(direct: false)  }
  scope :have_messages, -> { where.not(last_message: nil)  }
  scope :desc_order, -> { order(last_message: :desc)  }

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

  def members_except(user)
    members = self.users.reject { |e| e == user  }
    @user_names = members.map(&:username).join(", ")
  end

  def invited?(user)
    invitations.find_by(user_id: user.id)
  end


  private
  def set_default

    self.image ||= "http://d23mdu6au44x93.cloudfront.net/31896-36739-large/-line-friends-official-goods-brown-coaster.jpg"
  end
end
