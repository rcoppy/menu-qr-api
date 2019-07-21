class ItemsMenusController < ApplicationController
  before_action :set_item_menu, only: [:show, :update, :destroy]

  # GET /items_menus
  def index
    @items_menus = ItemMenu.all

    render json: @items_menus
  end

  # GET /items_menus/1
  def show
    render json: @item_menu
  end

  # POST /items_menus
  def create
    @item_menu = ItemMenu.new(item_menu_params)

    if @item_menu.save
      render json: @item_menu, status: :created, location: @item_menu
    else
      render json: @item_menu.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items_menus/1
  def update
    if @item_menu.update(item_menu_params)
      render json: @item_menu
    else
      render json: @item_menu.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items_menus/1
  def destroy
    @item_menu.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_menu
      @item_menu = ItemMenu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_menu_params
      params.require(:item_menu).permit(:menu_id, :item_id)
    end
end
