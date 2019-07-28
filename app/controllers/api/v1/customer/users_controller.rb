class Api::V1::Customer::UsersController < ApplicationController
  load_and_authorize_resource

  # user can view their own info
  def show 
    @user = current_user
    render json: @user
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  # def set_item
  #  @user = Item.find(params[:id])
  # end
end
