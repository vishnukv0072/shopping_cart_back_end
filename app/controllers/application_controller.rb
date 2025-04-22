class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  protect_from_forgery with: :null_session
  allow_browser versions: :modern

  def current_user
    # @current_user ||= User.where(id: session[:user_id]).last
    @current_user ||= User.last
  end

end
