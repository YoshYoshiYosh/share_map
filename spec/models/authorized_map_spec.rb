require 'rails_helper'

RSpec.describe AuthorizedMap, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:map) { FactoryBot.create(:map, title: 'other_userのMap', author: other_user) }
  let(:authorized_map) { FactoryBot.create(:authorized_map, user: user, map: map) }
  
  it 'is valid AuthorizedMap model' do
    expect(authorized_map).to be_valid
  end

  it 'is other_user\'s map that user can edit' do
    expect(authorized_map.user).to eq user
  end 
end
