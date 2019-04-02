class SearchController < ApplicationController
  before_action :get_header_category_brand

  def index
    if params[:keyword].length != 0
      @products = Product.where('name LIKE(?)', "%#{params[:keyword]}%").where('status = ?', '1').order('id DESC')
      @count = @products.count
    else
      @products = Product.where('status = ?', '1').order('id DESC').limit(24)
      @count = 0
    end
  end

  private
  def get_header_category_brand
    @brands = Brand.limit(5)

    @categories = Category.roots
    @categories.each do |large|
      large.children.limit(14).each do |middle|
        @categories+= [middle]
        middle.children.limit(14).each do |small|
          @categories+= [small]
        end
      end
    end
  end
end
