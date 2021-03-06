# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pins/index', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:map) { FactoryBot.create(:map, author: user) }
  let(:pins) do
    [FactoryBot.create(:pin, :same_author, map: map),
     FactoryBot.create(:pin, :same_author, map: map)]
  end

  before do
    assign(:user, user)
    assign(:map, map)
    assign(:pins, pins)
  end

  it 'renders a list of pins' do
    render

    assert_select 'div>small', text: 'ひとこと： test1-description', count: 1
    assert_select 'div>small', text: '作成者： test-1@example.com', count: 2
  end
end
