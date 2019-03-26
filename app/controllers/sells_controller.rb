class SellsController < ApplicationController
  def index
    @product = Product.new
    @product.build_delivary_option
    @product.product_images.build
  end
end
