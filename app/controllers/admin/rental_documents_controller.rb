module Admin
  class RentalDocumentsController < BaseController
    before_action :set_reservation
    before_action :set_document, only: [:update, :destroy]

    def create
      @document = @reservation.rental_documents.new(document_params)
      if @document.save
        redirect_to admin_reservation_path(@reservation), notice: "Document added for review."
      else
        redirect_to admin_reservation_path(@reservation), alert: @document.errors.full_messages.to_sentence
      end
    end

    def update
      @document.update(document_params)
      sync_document_status
      redirect_to admin_reservation_path(@reservation), notice: "Document status updated."
    end

    def destroy
      @document.destroy
      sync_document_status
      redirect_to admin_reservation_path(@reservation), notice: "Document removed."
    end

    private

    def set_reservation
      @reservation = Reservation.find(params[:reservation_id])
    end

    def set_document
      @document = @reservation.rental_documents.find(params[:id])
    end

    def document_params
      params.require(:rental_document).permit(:document_type, :file_name, :status, :notes)
    end

    def sync_document_status
      status = if @reservation.rental_documents.any? && @reservation.rental_documents.all? { |doc| doc.status == "Accepted" }
                 "Accepted"
               elsif @reservation.rental_documents.any? { |doc| doc.status == "Rejected" }
                 "Rejected"
               else
                 "Pending review"
               end
      @reservation.update(document_status: status)
    end
  end
end
