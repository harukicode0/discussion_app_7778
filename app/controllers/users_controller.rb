class UsersController < ApplicationController
  before_action :set_user, only: [:show, :followers, :followings, :your_joined_discussions]
  before_action :get_user_rooms, only: [:show, :your_joined_discussions]
  
  def show
    @rooms = Room.where(owner_id:@user.id).page(params[:page]).per(10)
  end

  def followings
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end

  def your_joined_discussions
    user_rooms = UserRoom.where(user_id: @user.id)
    @rooms = Room.where(id:user_rooms.pluck(:room_id)).page(params[:page]).per(10)
    render 'show'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end