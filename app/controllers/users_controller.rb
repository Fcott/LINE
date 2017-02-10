class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:show]

  def index
    @users = User.all - [current_user]
  end

  def show
    @user = User.find(params[:id])
    @users = User.all - [current_user]
    @rooms = Room.groups
  end

  private
  def correct_user
    redirect_to root_path unless current_user == User.find(params[:id])
  end
end
