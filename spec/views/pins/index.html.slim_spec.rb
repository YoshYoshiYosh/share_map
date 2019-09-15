require 'rails_helper'

RSpec.describe "pins/index", type: :view do

  let(:user) { FactoryBot.create(:user) }
  let(:map) { FactoryBot.create(:map, author: user) }
  let(:pins) { [FactoryBot.create(:pin, :same_author, map: map),
                FactoryBot.create(:pin, :same_author, map: map)] }

  before do
    assign(:user, user)
    assign(:map, map)
    assign(:pins, pins)
  end

  it "renders a list of pins" do
    render

    time = pins.first.created_at

    assert_select "div>small", :text => "ひとこと： test1-description", :count => 1
    assert_select "div>small", :text => "作成者： test-1@example.com", :count => 2
    assert_select "div>small", :text => "作成日時： #{time}", :count => 2
    assert_select "h1>a", :text => "＜ マップ管理画面へ戻る".to_s, :count => 1
  end
end