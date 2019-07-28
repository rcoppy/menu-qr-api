class Api::V1::Owner::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update]
  load_and_authorize_resource

  # GET /items
  def index
    @items = Item.where('restaurant_id IN (?)', current_user.restaurant_ids)  

    render json: @items
  end

  def show 
    @item = Item.find(id: params[:id])

    render json: @item
  end

  # POST /items
  def create
    # permit submitting many items at once
    # or just one item at a time
    # users can only make items in their own restaurants
    if current_user.restaurant_ids.include?(params[:id].to_i)
      if params[:item].nil? || params[:item].empty?
        @items = []
        bad_item = nil
        were_there_any_failures = false
        params[:items].each do |item|
          @items << Item.new(multiple_item_params(item).merge(restaurant_id: params[:id]))
          if !@items[-1].save
            were_there_any_failures = true
            bad_item = @items[-1]
            break
          end
        end

        unless were_there_any_failures
          render json: @items, status: :created, location: nil
        else 
          render json: bad_item.errors, status: :unprocessable_entity
        end
      else 
        puts "\n\n\n\ngoing with singular item, #{params[:item].nil?}, plural: #{params[:items].nil?}\n\n\n"
        @item = Item.new(item_params.merge(restaurant_id: params[:id]))

        if @item.save
          render json: @item, status: :created, location: nil
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end
    else
      render json: { error: "users can't submit to restaurants they don't own" }, status: :unprocessable_entity
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
      if !params[:item].nil? && !params[:item].empty?
        params.require(:item).permit(:name, :description, :price, :food_type)
      end
    end

    def multiple_item_params(item_hash)
      item_hash.require(:item).permit(:name, :description, :price, :food_type)
    end
end
