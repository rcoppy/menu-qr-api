class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # GET /items
  def index
    if current_user.is_restaurant_owner
      @items = Item.where(["restaurant_id IN (?)", current_user.restaurants)  
    else
      @items = Item.joins(:order_items).joins(:orders).where('orders.user_id = ?', current_user.id)
    end

    render json: @items
  end

  # GET /restaurants/1/items
  def restaurant_index 
    @items = Item.where(restaurant_id: params[:id])
    render json: @items
  end
  
  # GET /items/1
  def show
    render json: @item
  end

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:name, :description, :price)
    end
end
