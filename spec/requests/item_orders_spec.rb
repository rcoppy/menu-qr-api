require 'rails_helper'

RSpec.describe "ItemOrders", type: :request do
  describe "GET /item_orders" do
    it "works! (now write some real specs)" do
      get item_orders_path
      expect(response).to have_http_status(200)
    end
  end
end
