require 'rails_helper'

RSpec.describe "pins/index", type: :view do

  let(:user) { FactoryBot.create(:user) }
  let(:map) { FactoryBot.create(:map, author: user) }
  let(:pins) { [FactoryBot.create(:pin, :same_author, map: map),
                FactoryBot.create(:pin, :same_author, map: map)] }

  before do
    assign(:user, user)
    assign(:map, map)
    assign(:pins, pins)
  end

  it "renders a list of pins" do
    render
    assert_select "tr>th", :text => "Author".to_s, :count => 1
    assert_select "tr>th", :text => "Title".to_s, :count => 1
    assert_select "tr>th", :text => "Description".to_s, :count => 1
    assert_select "tr>th", :text => "Lonlat".to_s, :count => 1
    assert_select "tr>td", :text => /test-\d@example.com/, :count => 2
  end
end