class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

validates :username, presence: true, length: {maximum: 50}
has_many :user_rooms
has_many :rooms, through: :user_rooms

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
end
