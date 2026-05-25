module Admin
  class PaymentsController < BaseController
    before_action -> { require_permission!("payments.view") }
    def index
      @payments = Payment.includes(:reservation, :user).order(created_at: :desc)
      @paid_total = @payments.where(status: "Paid").sum(:amount)
    end
  end
end
