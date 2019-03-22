class SellsController < ApplicationController
  def index
    @product = Product.new
    # @delivary_option = DelivaryOption.new
    # = form.fields(model: @delivary_option) do |shipping|
    @product.build_delivary_option
  end
end
