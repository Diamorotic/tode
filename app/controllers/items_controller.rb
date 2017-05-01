class ItemsController < ApplicationController
  
  def show
  end
  
  def new
    @item = Item.new
  end
  
  def create
    fill_vars_user_list
    @item = @list.items.create(item_params)
    
    redirect_to edit_user_list_path(@user.id, @list.id)
  end
  
  def update
    fill_vars_user_list_item
    @item.change_bool
    @item.save
    redirect_to edit_user_list_path(params[:user_id], params[:list_id])
  end
  
  def destroy
    fill_vars_user_list_item
    @item.destroy
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
