require 'rails_helper'

RSpec.describe "maps/edit", type: :view do
  before(:each) do
    @map = assign(:map, Map.create!(
      :title => "MyString",
      :description => "MyText",
      :author_id => 1
    ))
  end

  it "renders the edit map form" do
    render

    assert_select "form[action=?][method=?]", map_path(@map), "post" do

      assert_select "input[name=?]", "map[title]"

      assert_select "textarea[name=?]", "map[description]"

      assert_select "input[name=?]", "map[author_id]"
    end
  end
end
