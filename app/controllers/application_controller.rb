class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    if current_user.present?
      true
    else
      respond_to do |format|
        format.html { redirect_to login_path, notice: 'Please, Login First.' }
        format.json { render json: 'Access denied', status: :unauthorized  }
      end
    end
  end
end
