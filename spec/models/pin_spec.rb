require 'rails_helper'

RSpec.describe Pin, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it 'is a valid pin object' do
    pin = FactoryBot.build(:pin, :same_author)
    expect(pin.author).to eq(pin.map.author)
  end

  it 'is invalid without map info.' do
    pin = FactoryBot.build(:pin, map: nil)
    expect(pin).not_to be_valid
  end
end