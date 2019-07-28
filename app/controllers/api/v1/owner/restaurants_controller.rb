class Api::V1::Owner::RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # thanks to cancan some authorization checks already taken care of re customer vs owner status

  # GET /restaurants
  def index
    # return restaurants that belong to current user
    if current_user.is_restaurant_owner
      @restaurants = Restaurant.where(owner_id: current_user.id)
    else 
      # non-owner has no restaurants
      @restaurants = []
    end

    render json: @restaurants
  end

  # GET /restaurants/1
  def show
    render json: @restaurant
  end

  # POST /restaurants
  def create

    # if this is user's first restaurant then make them an owner
    
    if !current_user.is_restaurant_owner
      current_user.is_restaurant_owner = true
      current_user.save
    end

    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      render json: @restaurant, status: :created, location: nil
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /restaurants/1
  def update
    if @restaurant.update(restaurant_params)
      render json: @restaurant
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /restaurants/1
  def destroy
    @restaurant.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :image).merge(owner_id: current_user.id)
    end
end
