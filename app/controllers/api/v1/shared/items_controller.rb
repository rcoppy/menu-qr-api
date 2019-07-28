class Api::V1::Shared::ItemsController < ApplicationController
  #load_and_authorize_resource

  # GET 
  def index
    @items = Item.where(restaurant_id: params[:id])

    render json: @items
  end

  # GET 
  def show 
    @item = Item.find(params[:id])
    render json: @item
  end
  
end