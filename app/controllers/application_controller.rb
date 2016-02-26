class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  rescue_from ActionController::ParameterMissing do |exception|
    flash[:error] = "#{exception.param} is required"
    redirect_to :back
  end

  def current_user
    @current_user ||= begin
      User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      flash[:error] = 'You must be logged in to access that.'
      redirect_to :root
    end
  end

  def require_admin
    require_login

    unless current_user.admin?
      flash[:error] = 'You must be an admin.'
      redirect_to :back
    end
  end
end
