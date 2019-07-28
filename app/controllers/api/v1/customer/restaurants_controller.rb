class Api::V1::Customer::RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show]
  load_and_authorize_resource

  # thanks to cancan some authorization checks already taken care of re customer vs owner status

  # GET /restaurants
  def index
    # return restaurants in nearby area
    # needs to be implemented later--for now just return all globally available restaurants
    # max_distance = params[:maxDistance]
    # location = { latitude: params[:latitude], longitude: params[:longitude] }

    # Restaurant.all.select do |restaurant|
    #  restaurant.distance_to(location) <= max_distance
    # end

    @restaurants = Restaurant.all

    render json: @restaurants
  end

  # GET /restaurants/1
  def show
    render json: @restaurant
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
