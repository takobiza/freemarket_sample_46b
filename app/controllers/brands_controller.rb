class BrandsController < ApplicationController
  def new
    @brands = Brand.where('name LIKE(?)', "%#{params[:brand_name_keyword]}%")
    respond_to do |format|
      format.html
      format.json
    end
  end
end
