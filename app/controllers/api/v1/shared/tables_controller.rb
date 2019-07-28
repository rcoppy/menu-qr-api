class Api::V1::Shared::TablesController < ApplicationController
  def index
    # return restaurants that belong to current user
    @tables = Table.where(restaurant_id: params[:id])

    render json: @tables
  end

  # GET /restaurants/1
  def show
    @table = Table.find(params[:id])
    render json: @table
  end
end