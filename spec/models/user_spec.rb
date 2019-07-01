require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it 'is valid model by factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end
end