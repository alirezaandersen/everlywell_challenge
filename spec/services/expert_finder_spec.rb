require 'rails_helper'

RSpec.describe ExpertFinder, type: :service do
  let(:user_1) { User.create(first_name: 'Joe', last_name: 'Biden') }
  let(:user_2) { User.create(first_name: 'Kamala',  last_name: 'Haris') }
  let(:user_3) { User.create(first_name: 'Donald',  last_name: 'Trump') }
  let(:user_4) { User.create(first_name: 'Mike', last_name: 'Pence') }
  let(:user_5) { User.create(first_name: 'George', last_name: 'Bush') }

  let(:friendship_1) {  { user_id: user_1.id, friend_id: user_2.id } }
  let(:friendship_2) {  { user_id: user_1.id, friend_id: user_3.id } }
  let(:friendship_3) {  { user_id: user_3.id, friend_id: user_4.id } }
  let(:friendship_4) {  { user_id: user_3.id, friend_id: user_5.id } }

  let!(:website_1) do
    Website.create(
      original_url: 'https://14123.com/',
      short_url: 'https://1234',
      user_id: user_1.id,
      header_values: ['cat in the hat', 'who let the dogs out', '2 birds in the hand']
    )
  end

  let!(:website_2) do
    Website.create(
      original_url: 'https://14123.com/',
      short_url: 'https://1234',
      user_id: user_2.id,
      header_values: %w[ballon fish unrealistic]
    )
  end

  let!(:website_3) do
    Website.create(
      original_url: 'https://14123.com/',
      short_url: 'https://1234',
      user_id: user_3.id,
      header_values: %w[useless time piece]
    )
  end
  let!(:website_4) do
    Website.create(
      original_url: 'https://14123.com/',
      short_url: 'https://1234',
      user_id: user_4.id,
      header_values: ['useless']
    )
  end
  let!(:website_5) do
    Website.create(
      original_url: 'https://14123.com/',
      short_url: 'https://1234',
      user_id: user_5.id,
      header_values: ['out of time']
    )
  end

  let(:search_string) { 'unrealistic' }
  let(:subject) { ExpertFinder.new(params) }
  let(:friends) { [friendship_1, friendship_2, friendship_3, friendship_4] }

  before do
    friends.each { |friendship| Friendship.create_reciprocal_for_ids(friendship) }
  end

  describe '#find_experts' do
    let(:params) { { user_id: user_3.id, search_string: search_string } }
    let(:network) { [[user_3.name], [user_1.name], [{ user_2.name => search_string }]] }

    it 'user finds expert through network' do
      expect(subject.find_experts_user).to eq(network)
    end
  end
end
