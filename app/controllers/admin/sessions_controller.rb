module Admin
  class SessionsController < ApplicationController
    layout "admin_auth"

    def new
    end

    def create
      user = User.find_by(email: params[:email].to_s.strip.downcase)

      if user&.authenticate(params[:password]) && user.admin_access?
        session[:user_id] = user.id
        user.update(last_login_at: Time.current)
        AdminAction.create!(user: user, action: "admin.login", ip_address: request.remote_ip, metadata: { path: request.fullpath }.to_json)
        redirect_to admin_root_path, notice: "Admin session started."
      else
        reset_session
        redirect_to new_admin_session_path, alert: "Admin access is restricted."
      end
    end

    def destroy
      reset_session
      redirect_to new_admin_session_path, notice: "Admin session ended."
    end
  end
end
