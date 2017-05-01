class ListsController < ApplicationController

  before_filter :authorize

  def index
    @user = current_user
    @lists = @user.lists
  end

  def show
    fill_vars_user_lists_list_items
  end
  
  def new
    @list = List.new
  end
  
  def edit
    fill_vars_user_lists_list_items
  end
  
  def create
    @list = current_user.lists.create(list_params)
    
    if @list.save
      redirect_to user_lists_path
    else
      render 'index'
    end
  end
  
  def destroy
    fill_vars_user_lists_list
    @list.destroy
    redirect_to user_lists_path
  end
  
  def fill_vars_user_lists_list
    @user = current_user
    @lists = @user.lists
    @list = @lists.find_by_id(params[:id])
  end
  
  def fill_vars_user_lists_list_items
    fill_vars_user_lists_list
    @items = @list.items
  end
  
  private
  def list_params
    params.require(:list).permit(:name)
  end
  
end
