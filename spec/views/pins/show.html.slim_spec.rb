require 'rails_helper'

RSpec.describe "pins/show", type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:map)  { FactoryBot.create(:map, author: user) }
  let(:pin)  { FactoryBot.create(:pin, :same_author, map: map, lonlat: "POINT (10.0 100.0)") }

  before(:each) do
    assign(:user, user)
    assign(:map, map)
    assign(:pin, pin)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/10.0 100.0/)
    expect(rendered).to match(/test\d-title/)
    expect(rendered).to match(/test\d-description/)
  end
end
