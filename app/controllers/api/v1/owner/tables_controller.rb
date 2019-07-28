class Api::V1::Owner::TablesController < ApplicationController
  before_action :set_table, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # thanks to cancan some authorization checks already taken care of re customer vs owner status

  # POST /restaurants
  def create
    if current_user.restaurant_ids.include?(params[:restaurant_id].to_i)
      # find new table number
      table_index = 1
      tables = Table.where(restaurant_id: params[:restaurant_id])
      if !tables.nil? && tables.count > 0
        tables.each do |table|
          table_index = table.table_number + 1 if table.table_number >= table_index
        end 
      end

      @table = Table.new(restaurant: Restaurant.find(params[:restaurant_id]), table_number: table_index)

      if @table.save
        render json: @table, status: :created, location: nil
      else
        render json: @table.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "can't add tables to restaurants you don't own" }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /restaurants/1
  def update
    if @table.update(table_params)
      render json: @table
    else
      render json: @table.errors, status: :unprocessable_entity
    end
  end

  # DELETE /restaurants/1
  #def destroy
  #  @table.destroy
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table
      @table = Table.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def table_params
      # params.require(:table).permit(:restaurant_id)
    end
end
