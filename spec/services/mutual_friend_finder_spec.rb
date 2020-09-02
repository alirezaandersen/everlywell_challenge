require 'rails_helper'

RSpec.describe MutualFriendFinder, type: :service do
  let(:user_1) { User.create(first_name: 'Joe', last_name: 'Biden', website_attributes: { original_url: 'https://joebiden.com/' }) }
  let(:user_2) { User.create(first_name: 'Kamala',  last_name: 'Haris', website_attributes: { original_url: 'https://www.harris.senate.gov/' }) }
  let(:user_3) { User.create(first_name: 'Donald',  last_name: 'Trump', website_attributes: { original_url: 'https://www.donaldjtrump.com/' }) }
  let(:user_4) { User.create(first_name: 'Mike', last_name: 'Pence', website_attributes: { original_url: 'https://www.presidentpence.com/' }) }
  let(:user_5) { User.create(first_name: 'George', last_name: 'Bush', website_attributes: { original_url: 'https://www.georgewbush.com/' }) }
  let(:user_6) { User.create(first_name: 'Barak', last_name: 'Obama', website_attributes: { original_url: 'https://barackobama.com/' }) }
  let(:friendship_1) {  { user_id: user_1.id, friend_id: user_2.id } }
  let(:friendship_2) {  { user_id: user_1.id, friend_id: user_5.id } }
  let(:friendship_3) {  { user_id: user_1.id, friend_id: user_6.id } }
  let(:friendship_4) {  { user_id: user_2.id, friend_id: user_6.id } }
  let(:subject) { MutualFriendFinder.new(mutual_friend_params) }

  describe '.mutual_friends' do
    let(:friends) { [friendship_1, friendship_2, friendship_3, friendship_4] }
    let(:mutual_friend_params) { { friend_id: user_1.id, user_id: user_2.id } }

    before do
      friends.each { |friendship| Friendship.create_reciprocal_for_ids(friendship) }
    end

    it 'should only return mutual friends' do
      expect(subject.mutual_friends.count).to eq(1)
      expect(subject.mutual_friends.first.name).to eq(user_5.name)
    end
  end
end
