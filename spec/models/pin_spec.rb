require 'rails_helper'

RSpec.describe Pin, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:map)  { FactoryBot.create(:map, author: user)}
  let(:pin)  { FactoryBot.create(:pin, :same_author, map: map)}
  
  it 'is a valid pin object' do
    expect(pin.author).to eq(pin.map.author)
  end

  it 'is invalid without map info.' do
    pin.update(map: nil)
    expect(pin).not_to be_valid
  end
end