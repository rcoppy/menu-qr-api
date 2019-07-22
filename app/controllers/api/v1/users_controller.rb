class Api::V1::UsersController < ApplicationController
  load_and_authorize_resource

  def index 
    # only chefs can query index of users
    # returned index consists of users who have an order with the chef
    @users = User.joins("INNER JOIN orders ON orders.customer_id = users.id").where(:orders => { chef_id: current_user.id })
    # get customers
    render json: @users
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  # def set_item
  #  @user = Item.find(params[:id])
  # end
end
