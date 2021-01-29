class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[show]

  # GET /friendships
  # GET /friendships.json
  def index
    @friendships = Friendship.all
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show; end

  # GET /friendships/new
  def new
    @friendship = Friendship.new
  end

  # GET /friendships/1/edit
  def edit; end

  # POST /friendships
  # POST /friendships.json
  def create
    @friendship = Friendship.new(sender_id: params[:sender], receiver_id: params[:receiver], status: 'requested')

    if @friendship.save
      flash[:notice] = 'Friendship was successfully created.'
    else
      flash[:alert] = 'Friendship not created!'
    end
    redirect_to user_path(params[:receiver])
  end

  # PATCH/PUT /friendships/1
  # PATCH/PUT /friendships/1.json
  def update
    @friendship = Friendship.where(sender_id: params[:sender], receiver_id: params[:receiver]).first

    if @friendship.update(status: params[:status])
      flash[:notice] = 'Friendship was successfully ' + params[:status] + '.'
    else
      flash[:alert] = 'Friendship not ' + params[:status] + '!'
    end
    redirect_to user_path(params[:sender])
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = Friendship.where(sender_id: params[:sender], receiver_id: params[:receiver]).first

    if @friendship.destroy
      flash[:notice] = 'Friendship was successfully removed.'
    else
      flash[:alert] = 'Friendship not removed!'
    end
    redirect_to user_path(params[:redirect_user])
    # if params[:receiver] == current_user[:id]
    # else
    #   redirect_to user_path(params[:receiver])
    # end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def friendship_params
    params.require(:friendship).permit(:sender_id, :receiver_id, :status)
  end
end
