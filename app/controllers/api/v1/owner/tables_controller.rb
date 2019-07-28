class Api::V1::Owner::TablesController < ApplicationController
  before_action :set_table, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # thanks to cancan some authorization checks already taken care of re customer vs owner status

  # POST /restaurants
  def create
    @table = Table.new(table_params)

    if @table.save
      render json: @table, status: :created, location: nil
    else
      render json: @table.errors, status: :unprocessable_entity
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
      params.require(:table).permit(:restaurant_id)
    end
end
