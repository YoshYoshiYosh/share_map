require 'rails_helper'

RSpec.describe PinsController, type: :controller do
  

  # This should return the minimal set of attributes required to create a valid
  # Pin. As you add validations to Pin, be sure to
  # adjust the attributes here as well.
  
  let(:user) { create(:user) }

  let(:map)  { create(:map, author: user) }

  let!(:same_author_pin) { create(:pin, :same_author, map: map, author: user) }

  let(:valid_attributes) { attributes_for(:pin, lonlat: '10 10') }

  let(:tmp_valid_attributes) {
    {
      title: "hello",
      description: 'description',
      lonlat: '10 10'
    }
  }

  let(:invalid_attributes) {
    {
      title: nil,
      description: nil,
      lonlat: '10 10'
    }
  }

  let(:map_and_pin_params) { { map_id: map.id, id: same_author_pin.id } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PinsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  context "user signed in" do
    login_user
    
    describe "GET #index" do
      it "returns a success response" do
        get :index, params: { map_id: map.id }, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        get :show, params: map_and_pin_params, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "GET #new"  do
      it "returns a success response" do
        get :new, params: { map_id: map.id }, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "GET #edit" do
      it "returns a success response" do
        get :edit, params: map_and_pin_params, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Pin" do
          expect {
            post :create, params: { map_id: map.id, pin: valid_attributes }, session: valid_session, format: :html
          }.to change(Pin, :count).by(1) 
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          expect {
            post :create, params: { map_id: map.id, pin: invalid_attributes }, session: valid_session, format: :js
          }.to change(Pin, :count).by(0)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {
            title: "rename",
            description: 'rename',
            lonlat: '100 100'
          }
        }

        it "updates the requested pin" do
          put :update, params: { map_id: map.id, id: same_author_pin.id, pin: new_attributes }, session: valid_session
          same_author_pin.reload
          expect(same_author_pin.title).to eq 'rename'
        end

        it "redirects to the pin" do
          put :update, params: { map_id: map.id, id: same_author_pin.id, pin: new_attributes }, session: valid_session
          expect(response).to redirect_to([map, same_author_pin])
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          # titleとかでvalidateさせてから、再度テストする
          put :update, params: { map_id: map.id, id: same_author_pin.id, pin: invalid_attributes }, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested pin" do
        expect {
          delete :destroy, params: { map_id: map.id, id: same_author_pin.id }, session: valid_session
        }.to change(Pin, :count).by(-1)
      end

      it "redirects to the pins list" do
        delete :destroy, params: { map_id: map.id, id: same_author_pin.id }, session: valid_session
        expect(response).to redirect_to(map_pins_url)
      end
    end

  end

end
