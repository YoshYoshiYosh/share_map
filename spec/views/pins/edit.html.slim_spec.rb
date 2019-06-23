require 'rails_helper'

RSpec.describe "pins/edit", type: :view do
  before(:each) do
    @pin = assign(:pin, Pin.create!(
      :author => nil,
      :title => "MyString",
      :description => "MyText",
      :lonlat => ""
    ))
  end

  it "renders the edit pin form" do
    render

    assert_select "form[action=?][method=?]", pin_path(@pin), "post" do

      assert_select "input[name=?]", "pin[author_id]"

      assert_select "input[name=?]", "pin[title]"

      assert_select "textarea[name=?]", "pin[description]"

      assert_select "input[name=?]", "pin[lonlat]"
    end
  end
end
