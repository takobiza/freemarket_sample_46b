class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    if @category.root?
      @category_descendants = @category.descendants
      first_id =@category_descendants.first.id
      last_id = @category_descendants.last.id
      @products = Product.where(category_id: first_id..last_id).where(status: true).order(created_at: "ASC").page(params[:page]).per(1)
      # binding.pry
      @category_children = @category.children.order("RAND()").limit(9)
    elsif @category.leaf?
      @products = Product.where(category_id: @category.id).where(status: true).order(created_at: "ASC").page(params[:page]).per(1)
      @category_children = []
    else
      @category_childrens = @category.children
      first_id =@category_childrens.first.id
      last_id = @category_childrens.last.id
      @products = Product.where(category_id: first_id..last_id).where(status: true).order(created_at: "ASC").page(params[:page]).per(1)
      @category_children = @category.children.order("RAND()").limit(9)
    end
  end

end
