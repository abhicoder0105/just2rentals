module Admin
  class LeadsController < BaseController
    before_action :set_lead, only: [:edit, :update, :destroy]

    def index
      @leads = Lead.pipeline_order
      @lead = Lead.new(status: "New", priority: "Medium", source: "Website", follow_up_on: Date.current + 1.day)
    end

    def create
      @lead = Lead.new(lead_params)
      if @lead.save
        redirect_to admin_leads_path, notice: "Lead captured."
      else
        @leads = Lead.pipeline_order
        render :index, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @lead.update(lead_params)
        redirect_to admin_leads_path, notice: "Lead updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @lead.destroy
      redirect_to admin_leads_path, notice: "Lead removed."
    end

    private

    def set_lead
      @lead = Lead.find(params[:id])
    end

    def lead_params
      params.require(:lead).permit(:name, :email, :phone, :trip_location, :preferred_vehicle, :source, :status, :priority, :follow_up_on, :budget, :notes)
    end
  end
end
