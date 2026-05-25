module Admin
  class BaseController < ApplicationController
    layout "admin"
    before_action :require_admin!

    private

    def require_admin!
      return if current_user&.admin_access?

      reset_session
      redirect_to new_admin_session_path, alert: "Admin access is restricted."
    end

    def audit_admin_action!(action, resource = nil)
      AdminAction.create!(
        user: current_user,
        action: action,
        resource_type: resource&.class&.name,
        resource_id: resource&.id,
        ip_address: request.remote_ip,
        metadata: { path: request.fullpath, params: params.to_unsafe_h.except("password") }.to_json
      )
    end

    def require_permission!(permission_key)
      return if current_user&.can?(permission_key)

      audit_admin_action!("permission.denied")
      redirect_to admin_root_path, alert: "You do not have permission to access that area."
    end
  end
end
