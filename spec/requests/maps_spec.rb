# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Maps', type: :request do
  describe 'GET /maps' do
    it 'works! (now write some real specs)' do
      get maps_path
      expect(response).to have_http_status(302)
    end
  end
end
