class UserRoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room

  def create
    @user_room = @room.user_rooms.where(user_id: current_user.id).first_or_create
    redirect_to @room
  end

  def destroy
    @user_room = @room.user_rooms.where(user_id: current_user.id).destroy_all
    @invitation = @room.invitations.where(user_id: current_user.id).destroy_all
    redirect_to current_user
  end

  private
  def set_room
    @room = Room.find(params[:room_id])
  end
end
