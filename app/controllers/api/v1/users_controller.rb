class Api::V1::UsersController < ApplicationController
  load_and_authorize_resource

  def index 
    # only chefs can query index of users
    # returned index consists of users who have an order with the chef
    @users = User.joins(:orders).find_by(chef_id: current_user.id)
    # get customers
    render json: resource
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  # def set_item
  #  @user = Item.find(params[:id])
  # end
end
