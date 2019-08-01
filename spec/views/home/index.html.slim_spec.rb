require 'rails_helper'

RSpec.describe "home/index.html.slim", type: :view do
  it "renders home page including word 'ShareMap'" do
    render
    assert_select "h2", :text => "ShareMap", :count => 1
  end
end
