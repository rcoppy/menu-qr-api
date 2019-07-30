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
    render json: { order: @order, items: @order.items }
  end

  # POST /orders
  def create
    @order = Order.new(:restaurant_id => params[:restaurant_id],
                       :table_id => params[:table_id],
                       :user_id => current_user.id)
    # need to assign items
    # items come in the form: 
    # {
    #   items: [id, id, id, id] 
    # }
    

    if @order.save   
      # order needs to be saved before order_items can be created
      order_item_hash = Hash.new(0)
      params[:order][:items].each do |item|
        order_item_hash[item[:item_id]] += item[:quantity]
      end
      order_item_hash.each do |item_id, quantity|
        OrderItem.create!(order: @order, item_id: item_id, quantity: quantity, item_price: Item.find(item_id).price)
      end
      
      render json: { order: @order, items: @order.items, relations: @order.order_items }, status: :created, location: nil
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
      @order = Order.find(params[:order_id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      # params.require(:order).permit(:restaurant_id, :table_id, :items => [])
      # strong params can't take an array of hashes :(
      # so as a hack for now we're gonna ignore it
    end

    def order_update_params
      params.require(:order).permit() # at the moment there's nothing the user can update
      # TODO: user cancel order 
    end
end
