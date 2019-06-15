require 'rails_helper'

RSpec.describe "maps/new", type: :view do
  before(:each) do
    assign(:map, Map.new(
      :title => "MyString",
      :description => "MyText",
      :author => nil
    ))
  end

  it "renders new map form" do
    render

    assert_select "form[action=?][method=?]", maps_path, "post" do

      assert_select "input[name=?]", "map[title]"

      assert_select "textarea[name=?]", "map[description]"

      assert_select "input[name=?]", "map[author_id]"
    end
  end
end
