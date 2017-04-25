class ListsController < ApplicationController

	def index
		@lists = List.all
	end

	def show
	end
	
	def new
		@list = List.new
	end
	
	def create
		#@lists = List.all
		#1/0
		@user = User.find_by_id(current_user[:id])
		@list = @user.lists.create(list_params)
		
		if @list.save
			#@TODO redirect_to @list
			redirect_to user_lists_path
		else
			render 'index'
		end
	end
	
	private
	def list_params
		#params[:list][:user] = current_user
		
		params.require(:list).permit(:name)
		#1/0
	end
	
end
