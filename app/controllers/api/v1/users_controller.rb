class Api::V1::UsersController < ApplicationController
  load_and_authorize_resource

  def index 
    @users = User.find
    render json: resource
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @user = Item.find(params[:id])
  end
end
