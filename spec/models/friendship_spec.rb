require 'rails_helper'

RSpec.describe Friendship, type: :model do
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
  let(:friendship_5) {  { user_id: user_3.id, friend_id: user_4.id } }
  let(:friendship_6) {  { user_id: user_4.id, friend_id: user_3.id } }
  let(:friendship_7) {  { user_id: user_3.id, friend_id: user_3.id } }

  describe 'relationships' do
    it { should belong_to(:friend).class_name('User') }
    it { should belong_to(:user) }

    xit 'has a counter cache' do
      # friends = Friendship.create(friendship_1)
      # expect{ friends.user }.to change { user_1.friends_count }.by(1)
    end
  end

  describe '.create_reciprocal_for_ids' do
    it 'creates a bi-directional friendship' do
      expect { described_class.create_reciprocal_for_ids(friendship_1) }.to change { Friendship.count }.by(2)
      expect(user_1.friends.first.name).to eq(user_2.name)
      expect(user_2.friends.first.name).to eq(user_1.name)
    end

    context '.user_to_friend' do
      it 'creates a single way friendship' do
        expect { described_class.user_to_friend(friendship_5) }.to change { Friendship.count }.by(1)
        expect(user_3.friends.first.name).to eq(user_4.name)
      end
    end

    context '.user_to_friend' do
      it 'creates a single way friendship' do
        expect { described_class.user_to_friend(friendship_6) }.to change { Friendship.count }.by(1)
        expect(user_4.friends.first.name).to eq(user_3.name)
      end
    end
  end

  describe '#cannot_friend_yourself' do
    it 'will not allow you to be friends with yourself' do
      expect { described_class.user_to_friend(friendship_7) }.to raise_error
    end
  end
end
