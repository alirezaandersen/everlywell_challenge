# create users with websites

users = [
  User.new(first_name: 'Joe', last_name: 'Biden', website_attributes: { original_url: 'https://joebiden.com/' }),
  User.new(first_name: 'Kamala',  last_name: 'Haris', website_attributes: { original_url: 'https://www.harris.senate.gov/' }),
  User.new(first_name: 'Donald',  last_name: 'Trump', website_attributes: { original_url: 'https://www.donaldjtrump.com/' }),
  User.new(first_name: 'Mike', last_name: 'Pence', website_attributes: { original_url: 'https://www.presidentpence.com/' }),
  User.new(first_name: 'George', last_name: 'Bush', website_attributes: { original_url: 'https://www.georgewbush.com/' }),
  User.new(first_name: 'Barak', last_name: 'Obama', website_attributes: { original_url: 'https://barackobama.com/' })
]

users.each do |candidate|
  candidate.website.get_additional_info
  candidate.save
end

# create friends
friends = [
  { user_id: User.find(1).id, friend_id: User.find(2).id },
  { user_id: User.find(1).id, friend_id: User.find(5).id },
  { user_id: User.find(1).id, friend_id: User.find(6).id },
  { user_id: User.find(3).id, friend_id: User.find(4).id },
  { user_id: User.find(4).id, friend_id: User.find(5).id }

]

friends.each do |friendships|
  Friendship.create_reciprocal_for_ids(friendships)
end
