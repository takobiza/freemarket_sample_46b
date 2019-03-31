class SellsController < ApplicationController
  def index
    @product = Product.new
    @product.build_delivary_option
    @product.product_images.build
    respond_to do |format|
      format.html
      format.json { @middle_categories = Category.find(params[:category_id]).children }
    end
  end

end
