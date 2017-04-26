class ItemsController < ApplicationController
	
	def new
		@item = Item.new
	end
	
	def create
		@user = User.find_by_id(current_user[:id])
		@list = @user.lists.find_by_id(params[:list_id])
		@item = @list.items.create(item_params)
		
		if @item.save
			redirect_to edit_user_list_path(@user.id, @list.id)
		else
			render edit_user_list_path(@user.id, @list.id)
		end
	end
	
	private
	def item_params
		params.require(:item).permit(:name)
	end
	
end
