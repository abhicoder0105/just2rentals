class BookingCancellationsController < ApplicationController
  before_action :require_customer!

  def update
    reservation = current_user.reservations.find(params[:reservation_id])
    if reservation.cancellable?
      reservation.update(status: "cancelled", cancelled_at: Time.current, cancellation_reason: params[:cancellation_reason].presence || "Customer cancelled")
      redirect_to account_path, notice: "Booking cancelled."
    else
      redirect_to account_path, alert: "This booking can no longer be cancelled."
    end
  end
end
