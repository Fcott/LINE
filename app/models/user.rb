class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  validates :username, presence: true, length: {maximum: 50}
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms
  has_many :messages
  has_many :invitations, dependent: :destroy
  has_many :invited_rooms, through: :invitations, class_name: Room

  def self.from_omniauth(auth)
     user = User.where(:email => auth.info.email).first
     if user
       return user
     else
       where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
         user.username = auth.info.name
         user.provider = auth.provider
         user.uid = auth.uid
         user.email = auth.info.email
         user.image = auth.info.image
         user.password = Devise.friendly_token[0,20]
       end
     end
   end

   def member_of?(room)
     user_rooms.find_by(room_id: room.id)
   end

   def unopen?(room)
     user_room = self.user_rooms.find_by(room_id: room.id)
     user_room.last_read_at < room.last_message
   end

end
