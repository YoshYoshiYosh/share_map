require 'rails_helper'

RSpec.describe "home/index.html.slim", type: :view do
  it "renders home page including word 'シェアマップ'" do
    render
    assert_select "h1", :text => "シェアマップ", :count => 1
  end
end
