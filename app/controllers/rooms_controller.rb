class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = current_user.rooms
  end

  def show
    @room = Room.find(params[:id])
    @user_rooms = @room.user_rooms
    @messages = Messages.where(user_room: @user_rooms)
  end
end
