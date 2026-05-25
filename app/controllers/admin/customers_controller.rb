module Admin
  class CustomersController < BaseController
    def index
      @customers = User.where(role: "customer").order(created_at: :desc)
    end
  end
end
