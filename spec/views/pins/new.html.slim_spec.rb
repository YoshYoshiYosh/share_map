require 'rails_helper'

RSpec.describe "pins/new", type: :view do
  before(:each) do
    assign(:pin, Pin.new(
      :author => nil,
      :title => "MyString",
      :description => "MyText",
      :lonlat => ""
    ))
  end

  it "renders new pin form" do
    render

    assert_select "form[action=?][method=?]", pins_path, "post" do

      assert_select "input[name=?]", "pin[author_id]"

      assert_select "input[name=?]", "pin[title]"

      assert_select "textarea[name=?]", "pin[description]"

      assert_select "input[name=?]", "pin[lonlat]"
    end
  end
end
