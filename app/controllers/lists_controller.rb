class ListsController < ApplicationController

	def index
		@user = User.find_by_id(current_user[:id])
	end

	def show
		@user = User.find_by_id(current_user[:id])
		@list = @user.lists.find_by_id(params[:id])
	end
	
	def new
		@list = List.new
	end
	
	def edit
		@user = User.find_by_id(current_user[:id])
		@list = @user.lists.find_by_id(params[:id])
	end
	
	def create
		@user = User.find_by_id(current_user[:id])
		@list = @user.lists.create(list_params)
		
		if @list.save
			redirect_to user_lists_path
		else
			render 'index'
		end
	end
	
	def destroy
		@user = User.find_by_id(current_user[:id])
		@list = @user.lists.find_by_id(params[:id])
		@list.destroy
		redirect_to user_lists_path
	end
	
	private
	def list_params
		params.require(:list).permit(:name)
	end
	
end
