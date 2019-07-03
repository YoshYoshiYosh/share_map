require 'rails_helper'

RSpec.describe "pins/new", type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:map)  { FactoryBot.create(:map, author: user)}
  
  before(:each) do
    assign(:user, user)
    assign(:map, map)
    assign(:pin, Pin.new(
      :title => "MyString",
      :description => "MyText",
      :lonlat => "10 10"
    ))
  end

  it "renders new pin form" do
    render

    assert_select "form[action=?][method=?]", map_pins_path(map), "post" do

      assert_select "input[name=?]", "pin[title]"

      assert_select "textarea[name=?]", "pin[description]"

      assert_select "input[name=?]", "pin[lonlat]"
    end
  end
end
