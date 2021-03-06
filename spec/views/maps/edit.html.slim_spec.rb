# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'maps/edit', type: :view do
  before(:each) do
    @map = assign(:map, Map.create!(
                          title: 'MyString',
                          description: 'MyText',
                          author: User.new
                        ))
  end

  it 'renders the edit map form' do
    render

    assert_select 'form[action=?][method=?]', map_path(@map), 'post' do
      assert_select 'input[name=?]', 'map[title]'

      assert_select 'textarea[name=?]', 'map[description]'
    end
  end
end
