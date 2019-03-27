class ProductsController < ApplicationController

  before_action :set_product, except: [:index]


  def index

    @items_ladies = get_category_SQL(159,336)
    @items_mens = get_category_SQL(337,465)
    @items_kids = get_category_SQL(466,581)
    @items_cosmetics = get_category_SQL(844,929)

    @items_chanel = brand_search(1)
    @items_vuitton = brand_search(2)
    @items_supreme = brand_search(3)
    @items_nike = brand_search(4)

  end

  def show

    @six_products_related_product = @product.six_products_related_product
    @six_products_related_user = Product.where(user_id: @product.user_id).limit(6)

  end

  private

  def category_search(category_name)
    ActiveRecord::Base.connection.select_all(create_get_category_SQL(category_name)).to_hash.map{|id| Product.find( id.fetch("id") )}
  end

  def brand_search(brand_id)
    Product.where(brand_id: brand_id).order("RAND()").limit(4)
  end

  # def create_get_category_SQL(category)
  #   sql = "SELECT products.id FROM `products` LEFT OUTER JOIN `categories` ON `categories`.`id` = `products`.`category_id` WHERE `large` = '#{category}' AND `status` = TRUE ORDER BY RAND() LIMIT 4"
  # end

  def get_category_SQL(low, high)
    ActiveRecord::Base.connection.select_all("SELECT products.id FROM `products` LEFT OUTER JOIN `categories` ON `categories`.`id` = `products`.`category_id` WHERE `products`.`category_id` BETWEEN #{low} AND #{high}  ORDER BY RAND() LIMIT 4").to_hash.map{|id| Product.find( id.fetch("id") )}
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.permit(:name, :price)
  end
end
