class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[show]

  def index
    @friendships = Friendship.all
  end

  def show; end

  def new
    @friendship = Friendship.new
  end

  def edit; end

  def create
    @friendship = Friendship.new(sender_id: params[:sender], receiver_id: params[:receiver])

    if @friendship.save
      flash[:notice] = 'Friendship was successfully created.'
    else
      flash[:alert] = 'Friendship not created!'
    end
    redirect_to user_path(params[:receiver])
  end

  def destroy_both
    @friendship = Friendship.where(sender_id: params[:receiver], receiver_id: params[:sender]).first
    if @friendship.destroy
      destroy
    else
      flash[:alert] = 'Friendship not removed!'
      redirect_to user_path(params[:receiver])
    end
  end

  def destroy
    @friendship = Friendship.where(sender_id: params[:sender], receiver_id: params[:receiver]).first

    if @friendship.destroy
      flash[:notice] = 'Friendship was successfully removed.'
    else
      flash[:alert] = 'Friendship not removed!'
    end
    redirect_to user_path(params[:redirect_user])
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:sender_id, :receiver_id, :status)
  end
end
