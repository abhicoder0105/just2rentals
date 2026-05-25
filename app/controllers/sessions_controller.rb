class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].to_s.strip.downcase)

    if user&.authenticate(params[:password]) && user.customer?
      session[:user_id] = user.id
      user.update(last_login_at: Time.current)
      redirect_to root_path, notice: "Welcome back."
    else
      redirect_to new_session_path, alert: "Invalid customer credentials."
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Signed out."
  end
end
