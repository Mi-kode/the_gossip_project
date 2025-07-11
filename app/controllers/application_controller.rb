class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  before_action :require_login

  def current_user
    @current_user ||=User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  private

  def require_login
    unless logged_in?
      if controller_name == "static_pages" && action_name == "home"
      else
        flash[:error] = "Tu dois être connecté pour accéder à cette page"
      end
      redirect_to login_path
    end
  end
end
