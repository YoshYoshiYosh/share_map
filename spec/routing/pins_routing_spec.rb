require "rails_helper"

RSpec.describe PinsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/maps/1/pins").to route_to("pins#index", map_id: '1')
    end

    it "routes to #new" do
      expect(:get => "/maps/1/pins/new").to route_to("pins#new", map_id: '1')
    end

    it "routes to #show" do
      expect(:get => "/maps/2/pins/1").to route_to("pins#show",map_id: "2", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/maps/3/pins/1/edit").to route_to("pins#edit", map_id: '3', :id => "1")
    end


    it "routes to #create" do
      expect(:post => "maps/1/pins").to route_to("pins#create", map_id: "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "maps/5/pins/1").to route_to("pins#update", map_id: '5', :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "maps/1/pins/1").to route_to("pins#update", map_id: '1', :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "maps/1/pins/1").to route_to("pins#destroy", map_id: '1', :id => "1")
    end
  end
end
