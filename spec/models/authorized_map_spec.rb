# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorizedMap, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  let(:map) { FactoryBot.create(:map, title: 'other_userのMap', author: other_user) }
  let(:authorized_map) { FactoryBot.build(:authorized_map, user: user, map: map) }

  it 'is valid AuthorizedMap model' do
    expect(authorized_map).to be_valid
    authorized_map.save
    expect(AuthorizedMap.count).to eq(1)
  end

  it 'is other_user\'s map that user can edit' do
    expect(authorized_map.user).to eq user
  end

  context 'when authorizing user who already had authorized the same map' do
    it 'is invalid AuthorizedMap model' do
      authorized_map.save
      new_authorized_map = AuthorizedMap.new(map: map, user: user)
      new_authorized_map.valid?
      expect(new_authorized_map.errors.messages[:base]).to include('すでに招待されているユーザーです')
    end
  end
end
