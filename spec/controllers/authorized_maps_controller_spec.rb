require 'rails_helper'

RSpec.describe AuthorizedMapsController, type: :controller do

  let(:user) { create(:user) }

  let(:map) { create(:map, author: user) }

  let(:other_user) { create(:user, email: 'other_user@example.com') }

  let(:valid_session) { {} } 

  context "When user signed in" do
    login_user

    describe "GET #index" do
      it "returns a success response" do
        get :index, params: { map_id: map.id }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

end
