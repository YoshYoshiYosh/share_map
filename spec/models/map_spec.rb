require 'rails_helper'

RSpec.describe Map, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "is a valid map model" do
    map = FactoryBot.build(:map)
    expect(map).to be_valid
  end
end
