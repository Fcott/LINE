class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = current_user.rooms
  end

  def show
    @room = Room.find(params[:id])
    @user_rooms = @room.user_rooms
  end

  def create

  end

  private
  def room_params
    params.require(:room).permit(:name)
  end
end
