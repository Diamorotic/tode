class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

#	@@sessions = {}
	
#	def add_session user_id
#		@@sessions[user_id] = user_id
#	end

	def current_user
		@current_user ||= User.find_by_id(session[:current_user_id]) if session[:current_user_id]
	end
	helper_method :current_user
	
#	def sessions_count
#		@@sessions.count
#	end
#	helper_method :sessions_count

	def authorize
		redirect_to '/login/index' unless @current_user
	end

end
