require "rails_helper"

RSpec.describe ItemMenusController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/item_menus").to route_to("item_menus#index")
    end

    it "routes to #show" do
      expect(:get => "/item_menus/1").to route_to("item_menus#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/item_menus").to route_to("item_menus#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/item_menus/1").to route_to("item_menus#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/item_menus/1").to route_to("item_menus#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/item_menus/1").to route_to("item_menus#destroy", :id => "1")
    end
  end
end
