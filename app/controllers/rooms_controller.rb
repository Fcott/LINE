class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def show
    @room = Room.find(params[:id])
    @user10 = @room.users.first(10)
    @user_names = @room.users.map(&:username).join(", ")
    @messages = @room.messages
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      @room.user_rooms.where(user_id: current_user.id).first_or_create
      redirect_to @room, notice: 'Chatroom was successfully created.'
    else
      render :new
    end
  end

  private
  def room_params
    params.require(:room).permit(:name, :image)
  end

end
