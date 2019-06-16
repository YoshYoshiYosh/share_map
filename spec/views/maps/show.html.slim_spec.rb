require 'rails_helper'

RSpec.describe "maps/show", type: :view do
  before(:each) do
    @map = assign(:map, Map.create!(
      :title => "Title",
      :description => "MyText",
      :author_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
