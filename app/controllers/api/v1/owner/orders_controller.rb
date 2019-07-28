class Api::V1::Owner::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # GET /orders
  def index
    @orders = Order.where(restaurant_id: params[:id])

    render json: @orders
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def order_params
    params.require(:order).permit(:user_id, :restaurant_id)
  end
end
