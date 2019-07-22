class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # GET /orders
  def index
    key = current_user.is_chef ? :chef_id : :customer_id

    @orders = Order.where(key => current_user.id)

    render json: @orders
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    # need to assign items
    # items come in the form: 
    # {
    #   items: [id, id, id, id] 
    # }
    params[:items].each do |item_id|
      ItemsOrder.create(order_id: @order.id, item_id: item_id)
    end

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:customer_id, :chef_id)
    end
end
