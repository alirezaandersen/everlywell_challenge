class MutualFriendFinder
  def initialize(input)
    @friend_id = input[:friend_id]
    @user_id = input[:user_id]
  end

  def mutual_friends
    # find the user's friends
    user_friends = User.find(@user_id).friendships.where.not(friend_id: @friend_id).pluck(:friend_id)
    excluded_friend_ids = user_friends + [@user_id]
    # find the friends friends
    friend_unique_friends = User.find(@friend_id).friendships.where.not(friend_id: excluded_friend_ids).pluck(:friend_id)
    # the unique friends
    User.where(id: friend_unique_friends)
  end
end
