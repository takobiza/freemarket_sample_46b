class CategoriesController < ApplicationController

  before_action :get_header_category_brand

  def show
    @category = Category.find(params[:id])
    if @category.root?
      @category_descendants = @category.descendants.select{|category| category.parent_id != @category.id}
      first_id =@category_descendants.first.id
      last_id = @category_descendants.last.id
      product = Product.where(category_id: first_id..last_id).where(status: true).order(created_at: "ASC")
      @count = product.count
      @products = product.page(params[:page]).per(14)
      @category_children = @category.children.order("RAND()").limit(9)
    elsif @category.leaf?
      product = Product.where(category_id: @category.id).where(status: true).order(created_at: "ASC")
      @products = product.page(params[:page]).per(14)
      @count = product.count
      @category_children = []
    else
      @category_childrens = @category.children
      first_id =@category_childrens.first.id
      last_id = @category_childrens.last.id
      product = Product.where(category_id: first_id..last_id).where(status: true).order(created_at: "ASC")
      @products = product.page(params[:page]).per(14)
      @count = product.count
      @category_children = @category.children.order("RAND()").limit(9)
    end
  end

  private
  def get_header_category_brand
    @brands = Brand.limit(5)

    @categories = Category.all
  end
end
