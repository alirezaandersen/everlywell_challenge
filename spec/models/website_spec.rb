require 'rails_helper'

RSpec.describe Website, type: :model do

  describe 'relationships' do
    it { should belong_to(:user) }
  end

  xdescribe 'validations' do
    it 'wont create a website class' do
    end
    it 'create a website class' do
    end
  end

  xdescribe '#generate_header_info' do

  end

  xdescribe '#generate_short_url' do

  end

end
