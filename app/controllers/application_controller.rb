class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :user_signed_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end

  def require_customer!
    return if current_user&.customer?

    redirect_to new_session_path, alert: "Please sign in to continue."
  end

  def deny_admin_url_guessing!
    head :not_found
  end
end
