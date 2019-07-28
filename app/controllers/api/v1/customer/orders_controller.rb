class Api::V1::Customer::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update]
  load_and_authorize_resource

  # GET /orders
  def index
    @orders = Order.where(:user_id => current_user.id)

    render json: @orders
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    @order = Order.new(order_params.merge(:customer_id => current_user.id))
    # need to assign items
    # items come in the form: 
    # {
    #   items: [id, id, id, id] 
    # }
    params[:items].each do |item_id|
      ItemsOrder.create(order_id: @order.id, item_id: item_id)
    end

    if @order.save
      render json: @order, status: :created, location: nil
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_update_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  # def destroy
  #  @order.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:restaurant_id)
    end

    def order_update_params
      params.require(:order).permit() # at the moment there's nothing the user can update
      # TODO: user cancel order 
    end
end
