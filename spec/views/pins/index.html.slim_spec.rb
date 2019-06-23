require 'rails_helper'

RSpec.describe "pins/index", type: :view do
  before(:each) do
    assign(:pins, [
      Pin.create!(
        :author => nil,
        :title => "Title",
        :description => "MyText",
        :lonlat => ""
      ),
      Pin.create!(
        :author => nil,
        :title => "Title",
        :description => "MyText",
        :lonlat => ""
      )
    ])
  end

  it "renders a list of pins" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
