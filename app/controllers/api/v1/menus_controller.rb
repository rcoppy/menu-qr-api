class Api::V1::MenusController < ApplicationController
  before_action :set_menu, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # GET /menus
  def index
    @menus = Menu.where(chef_id: current_user.id)

    render json: @menus
  end

  # GET /menus/1
  def show
    render json: @menu
  end

  def show_current_menu
    @menu = Menu.find_by(is_current: true, chef_id: params[:id])
    render json: @menu
  end

  def set_current_menu
    old_menu = Menu.find_by(is_current: true, chef_id: current_user.id)
    old_menu.is_current = false unless old_menu.nil?
    @menu = Menu.find_by(id: params[:id], chef_id: current_user.id)
    @menu.is_current = true
    render json: @menu
  end

  # POST /menus
  def create
    @menu = Menu.new(menu_params)
    
    params[:items].each do |item_id|
      items_menu.create(menu_id: @menu.id, item_id: item_id)
    end

    if @menu.save
      render json: @menu, status: :created, location: @menu
    else
      render json: @menu.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /menus/1
  def update
    if @menu.update(menu_params)
      render json: @menu
    else
      render json: @menu.errors, status: :unprocessable_entity
    end
  end

  # DELETE /menus/1
  def destroy
    @menu.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def menu_params
      params.require(:menu).permit(:chef_id, :name)
    end
end
