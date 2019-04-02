class SearchController < ApplicationController
  before_action :get_header_category_brand

  def index
    if params[:keyword].present?
      pre_products = Product.where('name LIKE(?)', "%#{params[:keyword]}%").where('status = ?', '1').order('id DESC')
      @count = pre_products.count
      @products = pre_products.page(params[:page]).per(16)
      if @products.empty?
        @products = Product.where('status = ?', '1').order('id DESC').limit(16)
        @count = 0
      end
    else
      @products = Product.where('status = ?', '1').order('id DESC').limit(16)
      @count = 0
    end
    # 開発の都合上perとlimitの数値を暫定的に16にしていますが、本来は24が正しい数値です.
    # また、24に変更する際はindex.htmlの18行目    - if @count <= 17    の17も同時に25に変更してください
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
