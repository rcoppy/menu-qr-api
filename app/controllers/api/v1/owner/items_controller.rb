class Api::V1::Owner::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update]
  load_and_authorize_resource

  # GET /items
  def index
    @items = Item.where('restaurant_id IN (?)', current_user.restaurants)  

    render json: @items
  end

  def show 
    @item = Item.find(id: params[:id])

    render json: @item
  end

  # POST /items
  def create
    @item = Item.new(item_params.merge(restaurant_id: params[:id]))

    if @item.save
      render json: @item, status: :created, location: nil
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
  # def destroy
  #   @item.destroy
  # end
  # directly deleting items will break existing orders

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
