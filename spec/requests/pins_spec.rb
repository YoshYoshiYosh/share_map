require 'rails_helper'

# https://github.com/plataformatec/devise/wiki/How-To:-sign-in-and-out-a-user-in-Request-type-specs-(specs-tagged-with-type:-:request)

RSpec.describe "Pins", type: :request do
  
  let(:user) { FactoryBot.create(:user) }
  let(:map) { FactoryBot.create(:map, author: user)}
  let(:same_author_pin) { FactoryBot.create(:pin, :same_author, map: map, author: user) }

  describe "GET maps/:map_id/pins" do
    it "works! (now write some real specs)" do
      user.confirm
      sign_in user
      get map_pins_path([map, same_author_pin])
      expect(response).to have_http_status(200)
    end
  end
end