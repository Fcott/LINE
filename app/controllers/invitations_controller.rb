class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room

  def create
    @invitation = @room.invitations.where(user_id: params[:user_id]).first_or_create
    redirect_back(fallback_location: root_path, notice: 'successfully invited.')
  end

  def destroy
    @invitation = @room.invitations.where(user_id: params[:user_id]).destroy_all
    redirect_back(fallback_location: root_path, notice: 'Invitation was canceled.')
  end

  private
  def set_room
    @room = Room.find(params[:room_id])
  end
end
