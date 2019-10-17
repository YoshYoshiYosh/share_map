# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'maps/show', type: :view do
  before(:each) do
    @map = assign(:map, Map.create!(
                          title: 'test-title',
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
    render template: "maps/show.html.slim"
    expect(rendered).to match(/ホーム/)
  end
end
