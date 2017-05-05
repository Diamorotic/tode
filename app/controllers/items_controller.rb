class ItemsController < ApplicationController
  
  before_filter :authorize
  
  def index
    fill_vars_user_list_item
    @items = @list.items
  end
  
  def show
  end
  
  def new
    @item = Item.new
  end
  
  def create
    fill_vars_user_list
    @item = @list.items.create(item_params)
    if @item.save
      ActionCable.server.broadcast 'items',
        item: @item.name
    end
    redirect_to edit_user_list_path(@user.id, @list.id)
  end
  
  def update
    fill_vars_user_list_item
    @item.change_bool
    if @item.save
      ActionCable.server.broadcast 'items',
        item: @item.name
    end
    redirect_to edit_user_list_path(params[:user_id], params[:list_id])
  end
  
  def destroy
    fill_vars_user_list_item
    if @item.destroy
      ActionCable.server.broadcast 'items',
        item: @item.name
    end
    redirect_to edit_user_list_path(@user.id, @list.id)
  end
  
  def fill_vars_user_list
    @user = current_user
    @list = @user.lists.find_by_id(params[:list_id])
  end
  
  def fill_vars_user_list_item
    fill_vars_user_list
    @item = @list.items.find_by_id(params[:id])
  end
  
  private
  def item_params
    params.require(:item).permit(:name)
  end
  
end
