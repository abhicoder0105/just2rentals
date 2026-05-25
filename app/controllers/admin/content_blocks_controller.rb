module Admin
  class ContentBlocksController < BaseController
    before_action -> { require_permission!("cms.manage") }
    def index
      @content_blocks = ContentBlock.order(:placement, :key)
      @content_block = ContentBlock.new(active: true, placement: "homepage")
    end

    def create
      @content_block = ContentBlock.new(content_params)
      if @content_block.save
        redirect_to admin_content_blocks_path, notice: "Content block saved."
      else
        @content_blocks = ContentBlock.order(:placement, :key)
        render :index, status: :unprocessable_entity
      end
    end

    private

    def content_params
      params.require(:content_block).permit(:key, :title, :body, :image_url, :active, :placement)
    end
  end
end
