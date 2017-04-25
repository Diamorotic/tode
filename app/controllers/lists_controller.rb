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
		@lists = List.all
		@list = List.new(list_params)
		
		if @list.save
			#@TODO redirect_to @list
			redirect_to lists_path
		else
			render 'index'
		end
	end
	
	private
	def list_params
		params.require(:list).permit(:name)
	end
	
end
