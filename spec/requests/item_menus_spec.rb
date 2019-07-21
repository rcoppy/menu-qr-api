require 'rails_helper'

RSpec.describe "ItemMenus", type: :request do
  describe "GET /item_menus" do
    it "works! (now write some real specs)" do
      get item_menus_path
      expect(response).to have_http_status(200)
    end
  end
end
