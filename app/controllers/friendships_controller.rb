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

  def mutual_friends
    @mutual_friends = MutualFriendFinder.new(mutual_friends_params).mutual_friends
    if @mutual_friends.present?
      render json: @mutual_friends, status: :ok
    else
      render json: { error: 'Neither of you have a network' }.to_json, status: 422
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end

  def mutual_friends_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
