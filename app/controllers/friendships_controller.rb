class FriendshipsController < ApplicationController
  def show_friends
    @friendship = Friendship.where(friend_id: params.permit(:user_id)[:user_id])
    render json: @friendship
  end

  def create
    @friendships = Friendship.create_reciprocal_for_ids(friendship_params)
    if @friendships.valid?
      render json: @friendships, status: :created
    else
      render json: @friendships.errors, status: :unprocessable_entity
    end
  end


  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
