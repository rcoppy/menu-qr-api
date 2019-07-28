class Api::V1::Owner::UsersController < ApplicationController
  load_and_authorize_resource

  # user can view their own info
  def show 
    @user = current_user
    render json: @user
  end

  def index 
    # only owners can query index of users
    # returned index consists of users who have an order with the chef
    @users = User.joins("INNER JOIN orders ON orders.user_id = users.id").where(:orders => ["restaurant_id IN (?)", current_user.restaurants] )
    # get customers
    render json: @users
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  # def set_item
  #  @user = Item.find(params[:id])
  # end
end
