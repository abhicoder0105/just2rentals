module Admin
  class SupportTicketsController < BaseController
    before_action -> { require_permission!("support.manage") }
    def index
      @support_tickets = SupportTicket.includes(:user, :reservation).order(created_at: :desc)
    end
  end
end
