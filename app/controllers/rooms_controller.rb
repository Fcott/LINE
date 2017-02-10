class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :edit, :update]

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def show
    @user10 = @room.users.first(10)
    members = @room.users.reject { |e| e == current_user  }
    @user_names = members.map(&:username).join(", ")
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

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: 'Chatroom was successfully updated.'
    else
      render :edit
    end
  end

  private
  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :image)
  end

end
