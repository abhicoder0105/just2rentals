module Admin
  class ReservationsController < BaseController
    before_action -> { require_permission!("bookings.manage") }
    before_action :set_reservation, only: [:show, :update, :approve, :deny]

    def index
      @status = params[:status]
      @reservations = Reservation.includes(:vehicle).order(created_at: :desc)
      @reservations = @reservations.where(status: @status) if @status.present?
    end

    def show
      @document = @reservation.rental_documents.new(status: "Pending review")
    end

    def update
      if @reservation.update(reservation_params.merge(reviewed_at: Time.current))
        redirect_to admin_reservation_path(@reservation), notice: "Reservation review updated."
      else
        render :show, status: :unprocessable_entity
      end
    end

    def approve
      @reservation.update(status: "approved", reviewed_at: Time.current, reviewed_by: current_user.name)
      audit_admin_action!("reservation.approve", @reservation)
      redirect_to admin_reservation_path(@reservation), notice: "Request approved."
    end

    def deny
      @reservation.update(status: "rejected", reviewed_at: Time.current, reviewed_by: current_user.name)
      audit_admin_action!("reservation.reject", @reservation)
      redirect_to admin_reservation_path(@reservation), alert: "Request denied."
    end

    private

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(:status, :deposit_amount, :deposit_status, :document_status, :admin_notes, :reviewed_by)
    end
  end
end
