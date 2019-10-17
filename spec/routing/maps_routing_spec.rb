# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/maps').to route_to('maps#index')
    end

    it 'routes to #new' do
      expect(get: '/maps/new').to route_to('maps#new')
    end

    it 'routes to #show' do
      expect(get: '/maps/1').to route_to('maps#show', map_id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/maps/1/admin/edit').to route_to('maps#edit', map_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/maps').to route_to('maps#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/maps/1').to route_to('maps#update', map_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/maps/1').to route_to('maps#update', map_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/maps/1').to route_to('maps#destroy', map_id: '1')
    end
  end
end
