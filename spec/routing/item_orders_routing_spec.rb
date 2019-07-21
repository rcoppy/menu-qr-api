require "rails_helper"

RSpec.describe ItemOrdersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/item_orders").to route_to("item_orders#index")
    end

    it "routes to #show" do
      expect(:get => "/item_orders/1").to route_to("item_orders#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/item_orders").to route_to("item_orders#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/item_orders/1").to route_to("item_orders#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/item_orders/1").to route_to("item_orders#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/item_orders/1").to route_to("item_orders#destroy", :id => "1")
    end
  end
end
