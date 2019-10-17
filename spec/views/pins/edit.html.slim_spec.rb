# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pins/edit', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:map)  { FactoryBot.create(:map, author: user) }
  let(:pin)  { FactoryBot.create(:pin, :same_author, map: map) }

  before(:each) do
    assign(:user, user)
    assign(:map, map)
    assign(:pin, pin)
  end

  it 'renders the edit pin form' do
    render

    assert_select 'form[action=?][method=?]', pin_path(map, pin), 'post' do
      assert_select 'input[name=?]', 'pin[title]'

      assert_select 'textarea[name=?]', 'pin[description]'

      assert_select 'input[name=?]', 'pin[lonlat]'
    end
  end
end
