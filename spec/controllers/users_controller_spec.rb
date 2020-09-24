require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user_1) { User.create(first_name: 'Joe', last_name: 'Biden', website_attributes: { original_url: 'https://joebiden.com/' }) }
  let!(:user_2) { User.create(first_name: 'Kamala', last_name: 'Haris', website_attributes: { original_url: 'https://www.harris.senate.gov/' }) }

  describe 'GET/index' do
    it 'returns  successful status for all users' do
      get(:index)
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'GET /show' do
    before { user_1.website }
    it 'returns successful status for single user' do
      get(:show, params: { id: user_1.id })
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'PUT /create' do
    let(:user_params) { { user: { first_name: 'Ali', last_name: 'Andersen', website_attributes: { original_url: 'https://cuculifoods.com/' } } } }

    it 'returns successful response when user is created' do
      post(:create, params: user_params)
      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns unprocessable_entity response when user cannot be created' do
      post(:create, params: { user: { website_attributes: { original_url: 'https://cuculifoods.com/' } } })
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end
end
