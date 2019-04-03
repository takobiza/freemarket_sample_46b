class BrandsController < ApplicationController
  def new
    respond_to do |format|
      format.html
      format.json { @brand_id = Brand.find_by(name: params[:brand_name]).id }
    end
  end
end
