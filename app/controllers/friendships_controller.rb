class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[show edit update]

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
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
        format.json { render :show, status: :ok, location: @friendship }
      else
        format.html { render :edit }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = Friendship.where(sender_id: params[:sender], receiver_id: params[:receiver]).first
    if @friendship.destroy
      flash[:notice] = 'Friend request was successfully deleted.'
    else
      flash[:alert] = 'Friend request not deleted!'
    end
    redirect_to user_path(params[:receiver])
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
