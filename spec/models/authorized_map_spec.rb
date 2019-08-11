require 'rails_helper'

RSpec.describe AuthorizedMap, type: :model, focus: true do

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  let(:map) { FactoryBot.create(:map, title: 'other_userのMap', author: other_user) }
  let(:authorized_map) { FactoryBot.create(:authorized_map, user: user, map: map) }
  
  it 'is valid AuthorizedMap model' do
    expect(authorized_map).to be_valid
    expect(AuthorizedMap.count).to eq(1)
  end

  it 'is other_user\'s map that user can edit' do
    expect(authorized_map.user).to eq user
  end

  context 'when authorizing the user who already had authorized the same map' do
    it 'raises ActiveRecord::RecordInvalid error.' do
      map.authorizing_user(user)
      expect{map.authorizing_user(user)}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
