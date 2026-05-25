module Admin
  class TeamController < BaseController
    before_action -> { require_permission!("team.manage") }

    def index
      @admins = User.where(role: User::ROLES - ["customer"]).includes(:permissions).order(:role, :name)
      @permissions = Permission.order(:category, :key)
      @invitation = AdminInvitation.new(role: "support_agent")
      @invitations = AdminInvitation.order(created_at: :desc).limit(12)
    end

    def invite
      @invitation = AdminInvitation.new(invitation_params.merge(invited_by: current_user))
      if @invitation.save
        audit_admin_action!("team.invite", @invitation)
        redirect_to admin_team_index_path, notice: "Invitation generated."
      else
        @admins = User.where(role: User::ROLES - ["customer"]).includes(:permissions).order(:role, :name)
        @permissions = Permission.order(:category, :key)
        @invitations = AdminInvitation.order(created_at: :desc).limit(12)
        render :index, status: :unprocessable_entity
      end
    end

    def update_permissions
      user = User.find(params[:user_id])
      user.permission_ids = Array(params[:permission_ids]).reject(&:blank?)
      audit_admin_action!("team.permissions.update", user)
      redirect_to admin_team_index_path, notice: "Permissions updated."
    end

    private

    def invitation_params
      params.require(:admin_invitation).permit(:email, :role)
    end
  end
end
