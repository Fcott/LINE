class DirectsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    users = [current_user, @user]
    @room = Room.direct_message_for(users)
    @messages = @room.messages
    @user_names = @room.users.map(&:username).join(", ")
    render 'rooms/show' 
  end
end
