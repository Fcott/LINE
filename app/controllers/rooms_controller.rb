class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def show
    @user10 = @room.users.first(10)
    @messages = @room.messages.recent_100
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

  def invitation
    @room = Room.find(params[:room_id])
    users = @room.users
    @users = User.all.reject{|e| users.include?(e)}
  end

  private
  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :image)
  end

  def correct_user
    redirect_to current_user unless current_user.member_of?(@room)
  end

end
