class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by_id(session[:current_user_id]) if session[:current_user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to root_path unless current_user && @current_user[:id].to_s == params[:user_id]
  end

end
