class ItemsOrdersController < ApplicationController
  before_action :set_item_order, only: [:show, :update, :destroy]

  # GET /items_orders
  def index
    @items_orders = ItemOrder.all

    render json: @items_orders
  end

  # GET /items_orders/1
  def show
    render json: @item_order
  end

  # POST /items_orders
  def create
    @item_order = ItemOrder.new(item_order_params)

    if @item_order.save
      render json: @item_order, status: :created, location: @item_order
    else
      render json: @item_order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items_orders/1
  def update
    if @item_order.update(item_order_params)
      render json: @item_order
    else
      render json: @item_order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items_orders/1
  def destroy
    @item_order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_order
      @item_order = ItemOrder.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_order_params
      params.require(:item_order).permit(:order_id, :item_id)
    end
end
