class ProductsController < ApplicationController
  def index

    @items_ladies = category_search("レディース")
    @items_mens = category_search("メンズ")
    @items_kids = category_search("ベビー・キッズ")
    @items_cosmetics = category_search("コスメ・香水・美容")

    @items_chanel = brand_search(1)
    @items_vuitton = brand_search(2)
    @items_supreme = brand_search(3)
    @items_nike = brand_search(4)

  end

  def show
  end

  private

  def category_search(category_name)
    ActiveRecord::Base.connection.select_all(create_get_category_SQL(category_name)).to_hash.map{|id| Product.find( id.fetch("id") )}
  end

  def brand_search(brand_id)
    Product.where(brand_id: brand_id).order("RAND()").limit(4)
  end

  def create_get_category_SQL(category)
    sql = "SELECT products.id FROM `products` LEFT OUTER JOIN `categories` ON `categories`.`id` = `products`.`category_id` WHERE `large` = '#{category}' AND `status` = TRUE ORDER BY RAND() LIMIT 4"
  end
end
