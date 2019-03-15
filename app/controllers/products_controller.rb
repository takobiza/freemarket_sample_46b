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
end


  def category_search(category_name)
    Category.where(large: category_name).order("RAND()").limit(4).map{ |category| Product.find_by(category_id: category.id)}
  end

  def brand_search(brand_id)
    Product.where(brand_id: brand_id).order("RAND()").limit(4)
  end
