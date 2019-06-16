require 'rails_helper'

RSpec.describe "maps/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :email => 'yoshikik@live.jp',
      :password => 'Password',
      :password_confirmation => 'Password'
    ))
    
    @map = assign(:map, Map.create!(
      :title => "Title",
      :description => "MyText",
      :author => @user
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
