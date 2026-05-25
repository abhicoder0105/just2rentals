module Admin
  class DashboardController < BaseController
    def index
      @vehicles_count = Vehicle.count
      @pending_requests = Reservation.where(status: "pending").count
      @active_rentals = Reservation.where(status: "active").count
      @overdue_returns = Reservation.where(status: "active").where("dropoff_date < ?", Date.current).count
      @maintenance_alerts = MaintenanceLog.where(status: ["Scheduled", "Overdue"]).where("scheduled_on <= ?", Date.current + 7.days).count
      @deposits_paid = Reservation.where(deposit_status: "Paid").sum(:deposit_amount)
      @monthly_revenue = Payment.where(status: "Paid", paid_at: Time.current.beginning_of_month..Time.current.end_of_month).sum(:amount)
      @utilization = Vehicle.count.zero? ? 0 : (Vehicle.all.sum(&:utilization_percent) / Vehicle.count)
      @open_leads = Lead.where.not(status: ["Managed", "Lost"]).count
      @recent_reservations = Reservation.includes(:vehicle).order(created_at: :desc).limit(6)
      @lead_pipeline = Lead.group(:status).count
      @recent_activity = AdminAction.includes(:user).order(created_at: :desc).limit(8)
    end
  end
end
