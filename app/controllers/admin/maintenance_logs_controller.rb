module Admin
  class MaintenanceLogsController < BaseController
    before_action -> { require_permission!("maintenance.manage") }
    def index
      @maintenance_logs = MaintenanceLog.includes(:vehicle).order(scheduled_on: :asc)
      @maintenance_log = MaintenanceLog.new(status: "Scheduled", scheduled_on: Date.current + 7.days)
    end

    def create
      @maintenance_log = MaintenanceLog.new(maintenance_params)
      if @maintenance_log.save
        redirect_to admin_maintenance_logs_path, notice: "Maintenance log added."
      else
        @maintenance_logs = MaintenanceLog.includes(:vehicle).order(scheduled_on: :asc)
        render :index, status: :unprocessable_entity
      end
    end

    private

    def maintenance_params
      params.require(:maintenance_log).permit(:vehicle_id, :status, :service_type, :scheduled_on, :completed_on, :cost, :odometer, :notes)
    end
  end
end
