class DirectsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    users = [current_user, @user]
    @room = Room.direct_message_for(users)
    @messages = @room.messages
    members = @room.users.reject { |e| e == current_user  }
    @user_names = members.map(&:username).join(", ")
    render 'rooms/show'
  end
end
