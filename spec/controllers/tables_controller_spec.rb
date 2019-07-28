require 'rails_helper'

RSpec.describe TablesController, type: :controller do

  describe "GET #index,show,create" do
    it "returns http success" do
      get :index,show,create
      expect(response).to have_http_status(:success)
    end
  end

end
