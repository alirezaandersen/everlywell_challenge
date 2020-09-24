require 'rails_helper'
RSpec.describe User, type: :model do
  subject { User.new(first_name: 'Zara', last_name: 'Andersen') }

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'relationships' do
    it { should have_many(:friendships) }
    it { should have_many(:friends).through(:friendships) }
    it { should have_one(:website) }
  end

  context '#name' do
    it { expect(subject.name).to eq('Zara Andersen') }
  end
end
