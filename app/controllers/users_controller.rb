class UsersController < ApplicationController

	def new
		@user = User.new
	end
	
	def create
		@user = User.find_by_name(user_params[:name])
		logger.info "UserController.create user_params[:name]: #{user_params[:name]}"
		logger.debug "User nil" unless @user
		if @user 
			logger.debug "User found, name:  #{@user.name}"
			if @user.authenticate(user_params[:password])
				logger.debug "User loged in succesfully @user.id: #{@user.id}"
				#add_session[:user_id] = @user.id
				#add_session @user.id
				session[:current_user_id] = @user.id
				redirect_to user_lists_path(@user.id)
			else
				logger.info "User (#{@user.name}) log in failure: wrong password"
				flash[:error] = 'User name taken. Wrong passowrd.'
			end
		else
			@user = User.new(user_params)
			logger.info "Registering new user: #{@user.name}"
			if @user.save
				logger.debug "User (#{@user.name}) succesfully registered"
				session[:current_user_id] = @user.id
				redirect_to user_lists_path(@user.id), notice: 'User succesfully created'
			else
				logger.debug "Error while registering new user"
				flash[:error] = 'An error occured'
				render '/login/index'
			end
		end
=begin
		if User.find_by_name(params[:name])
			#@TODO not the most efective way - double find
			@user = User.find_by_name(params[:name])
			redirect_to lists_path
		else
			@user = User.new(user_params)
			if @user.save
				redirect_to lists_path
			else
				render '/login/index'
			end
		end
=end
	end
	
	private
	def user_params
		params.require(:user).permit(:name, :password)
	end
	
end
