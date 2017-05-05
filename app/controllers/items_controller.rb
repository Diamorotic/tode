class ItemsController < ApplicationController
  
  before_filter :authorize
  
  def index
    fill_vars_user_list_item
    @items = @list.items
    #redirect_to edit_user_list_path(params[:user_id], params[:list_id])
  end
  
  def show
  end
  
  def new
    @item = Item.new
  end
  
  def create
    fill_vars_user_list
    @item = @list.items.create(item_params)
#=begin
    if @item.save
      ActionCable.server.broadcast 'items',
        done: "",
        item: @item.name
      head :ok
    end
#=end
#    redirect_to edit_user_list_path(@user.id, @list.id)
=begin
  respond_to do |format|
      if @item.save
        format.html { redirect_to edit_user_list_path(@user.id, @list.id), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
=end
  end
  
  def update
    fill_vars_user_list_item
    @item.change_bool
    if @item.save
      if @item.done
        tick = "Y"
      else
        tick = ""
      end
      ActionCable.server.broadcast 'items',
        done: tick,
        item: @item.name
      head :ok
    end
#    redirect_to edit_user_list_path(params[:user_id], params[:list_id])
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
