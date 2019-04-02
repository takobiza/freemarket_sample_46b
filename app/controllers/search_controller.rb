class SearchController < ApplicationController
  def index
    if params[:keyword].length != 0
      @products = Product.where('name LIKE(?)', "%#{params[:keyword]}%").where('status = ?', '1').order('id DESC')
      @count = @products.count
    else
      @products = Product.where('status = ?', '1').order('id DESC').limit(24)
      @count = 0
    end
  end
end
