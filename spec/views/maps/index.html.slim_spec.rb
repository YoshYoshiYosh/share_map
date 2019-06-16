require 'rails_helper'

RSpec.describe "maps/index", type: :view do
  before(:each) do
    assign(:maps, [
      Map.create!(
        :title => "Title",
        :description => "MyText",
        :author => User.new
      ),
      Map.create!(
        :title => "Title",
        :description => "MyText",
        :author => User.new
      )
    ])
  end

  it "renders a list of maps" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
