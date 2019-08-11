require 'rails_helper'

RSpec.describe AuthorizedMap, type: :model do

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
    it 'is invalid AuthorizedMap model' do
      map.authorizing_user(user)
      new_authorized = FactoryBot.build(:authorized_map, user: user, map: map)
      new_authorized.valid?
      # expect{map.authorizing_user(user)}.to raise_error(ActiveRecord::RecordInvalid)
      expect(new_authorized.errors[:map]).to include('has already been taken')
    end
  end
end
