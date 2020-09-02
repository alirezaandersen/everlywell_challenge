class Friendship < ApplicationRecord
  # idea of design came from: https://medium.com/@miss.leslie.hsu/001-mutual-friendships-on-your-app-in-4-easy-steps-55cb27622585
  belongs_to :user, counter_cache: :friends_count
  belongs_to :friend, class_name: 'User'

  validates :user, uniqueness: { scope: :friend }
  validate :cannot_friend_yourself

  def self.create_reciprocal_for_ids(input)
    user_to_friend(input)
    friend_to_user(input)
  end

  def self.user_to_friend(input)
    friendships = { user_id: input[:user_id], friend_id: input[:friend_id] }
    Friendship.where(friendships).first_or_create
  end

  def self.friend_to_user(input)
    friendships = { user_id: input[:friend_id], friend_id: input[:user_id] }
    Friendship.where(friendships).first_or_create
  end

  def self.destroy_reciprocal_for_ids(input)
    user_friends = { user_id: input[:friend_id], friend_id: input[:user_id] }
    Friendship.find_by(user_friends).destroy

    friend_friends = { user_id: input[:friend_id], friend_id: input[:user_id] }
    Friendship.find_by(friend_friends).destroy
  end

  def cannot_friend_yourself
    unless user_id.nil?
      errors.add('can not be friend with yourself') if user_id == friend_id
    end
  end
end
