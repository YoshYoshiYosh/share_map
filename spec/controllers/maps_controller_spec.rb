require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe MapsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Map. As you add validations to Map, be sure to
  # adjust the attributes here as well.
  
  let(:user) { FactoryBot.create(:user) }
  
  let(:map) { FactoryBot.create(:map, author: user) }

  let(:valid_attributes) {
    {
      title: 'テストタイトル',
      description: '説明'
    }
  }

  let(:invalid_attributes) {
    {
      title: nil,
      description: 'test'
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MapsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  context "user signed in" do
    login_user

    describe "GET #index" do
      it "returns a success response" do
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end
  
    describe "GET #show" do
      it "returns a success response" do
        get :show, params: { id: map.id }, session: valid_session
        expect(response).to be_successful
      end
    end
  
    describe "GET #edit" do
      it "returns a success response" do
        get :edit, params: { id: map.id }, session: valid_session
        expect(response).to be_successful
      end
    end
  
    describe "POST #create" do
      context "with valid params" do
        it "creates a new Map" do
          expect {
            post :create, params: {map: valid_attributes}, session: valid_session
          }.to change(Map, :count).by(1)
        end
  
        it "redirects to the created map" do
          post :create, params: {map: valid_attributes}, session: valid_session
          expect(response).to redirect_to(Map.last)
        end
      end
  
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {map: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end
  
    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {
            title: '新しい名前',
            description: '新しい説明'
          }
        }
  
        it "updates the requested map" do
          put :update, params: {id: map.id, map: new_attributes}, session: valid_session
          map.reload
          expect(map.title).to eq '新しい名前'
        end
  
        it "redirects to the map" do
          put :update, params: {id: map.id, map: new_attributes}, session: valid_session
          expect(response).to redirect_to(map)
        end
      end
  
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          put :update, params: {id: map.id, map: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end
  
    describe "DELETE #destroy" do
      it "destroys the requested map" do
        map
        expect {
          delete :destroy, params: {id: map.id}, session: valid_session
        }.to change(Map, :count).by(-1)
      end
  
      it "redirects to the maps list" do
        delete :destroy, params: {id: map.id}, session: valid_session
        expect(response).to redirect_to(maps_url)
      end
    end
  end

  context "user don't login" do
    
    describe "GET #new" do
      it "returns a success response" do
        get :new, params: {}, session: valid_session
        expect(response).to redirect_to "/users/sign_in"
      end
    end

  end

end
