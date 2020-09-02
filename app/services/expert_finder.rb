class ExpertFinder
  def initialize(input)
    @user_id = input[:user_id]
    @search_string = input[:search_string]
  end

  def find_experts_user
    # returns all users who have meet the search criteria
    user_expert_ids = Website.where("array_to_string(header_values, '||') ILIKE :user_id",
                                    user_id: "%#{@search_string}%").pluck(:user_id)

    # search to see if any of immediate friends are experts
    user_has_friend_that_is_expert = Friendship.where(friend_id: user_expert_ids, user_id: @user_id)

    return user_has_friend_that_is_expert if user_has_friend_that_is_expert.present?

    check_network(user_expert_ids)
  end

  def check_network(user_expert_ids)
    # search to see if any of my friends are friends with the expert.
    # pull up all of my friends
    all_of_users_friends_ids = User.find(@user_id).friends.pluck(:id)

    # search each friend to see if they are friends with user_expert_ids
    friends_that_know_expert_ids = Friendship.where(friend_id: all_of_users_friends_ids,
                                                    user_id: user_expert_ids)
                                             .pluck(:friend_id, :user_id)
                                             .flatten!
    # returns array with remaining all_of_users_friends_ids and user_ids(user_expert_ids) to compare

    # compare that friends_that_know_expert_ids is user_expert_ids
    my_friends_id = friends_that_know_expert_ids.first
    my_friends_expert_friend_id = friends_that_know_expert_ids.last
    if user_expert_ids == [my_friends_expert_friend_id]
      [[User.find(@user_id).name],
      [User.find(my_friends_id).name],
      [{ User.find(my_friends_expert_friend_id).name => @search_string }]]
    end
  end

  def no_expert_in_network_of_friends
    errors.add('No one in your network knows that Expert User') if check_network(user_expert_ids).blank?
  end
end
