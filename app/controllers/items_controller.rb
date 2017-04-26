class ItemsController < ApplicationController
	
	def show
		change_bool
		@item.save
		redirect_to edit_user_list_path(params[:user_id], params[:list_id])
	end
	
	def new
		@item = Item.new
	end
	
	def create
		fill_user_list
		@item = @list.items.create(item_params)
		
		redirect_to edit_user_list_path(@user.id, @list.id)
	end
	
	def update
		change_bool
		@item.save
		redirect_to edit_user_list_path(@user.id, @list.id)
	end
	
	def destroy
		fill_user_list
		@item = Item.find_by_id(params[:id])
		@item.destroy
		redirect_to edit_user_list_path(@user.id, @list.id)
	end
	
	def fill_user_list
		@user = User.find_by_id(current_user[:id])
		@list = @user.lists.find_by_id(params[:list_id])
	end
	
	def change_bool
		@item = Item.find_by_id(params[:id])
		@item.done = !@item.done
	end
	
	private
	def item_params
		params.require(:item).permit(:name)
	end
	
end
