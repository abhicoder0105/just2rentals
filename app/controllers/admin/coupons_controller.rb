module Admin
  class CouponsController < BaseController
    before_action -> { require_permission!("pricing.manage") }
    def index
      @coupons = Coupon.order(created_at: :desc)
      @coupon = Coupon.new(discount_type: "percent", active: true)
    end

    def create
      @coupon = Coupon.new(coupon_params)
      if @coupon.save
        redirect_to admin_coupons_path, notice: "Coupon created."
      else
        @coupons = Coupon.order(created_at: :desc)
        render :index, status: :unprocessable_entity
      end
    end

    private

    def coupon_params
      params.require(:coupon).permit(:code, :description, :discount_type, :value, :starts_on, :ends_on, :active, :usage_limit)
    end
  end
end
