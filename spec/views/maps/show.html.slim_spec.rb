# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'maps/show', type: :view do
  before(:each) do
    @map = assign(:map, Map.create!(
                          title: 'Title',
                          description: 'MyText',
                          author: User.new
                        ))

    @pin = assign(:pin, Pin.create!(
                          title: 'pin-title',
                          description: 'pin-description',
                          lonlat: 'POINT(10 10)',
                          map: @map,
                          author: User.new
                        ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Map一覧/)
  end
end
