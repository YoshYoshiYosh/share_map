# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Map, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:map)  { FactoryBot.create(:map, author: user) }

  it 'is a valid map model' do
    expect(map).to be_valid
    expect(map.author.email).to eq user.email
  end
end
