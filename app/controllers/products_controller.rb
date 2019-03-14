class ProductsController < ApplicationController
  def index

    @items_ladies = Category.where(large: "レディース").order("RAND()").limit(4).map{ |category| Product.find_by(category_id: category.id)}
    @items_mens = Category.where(large: "メンズ").order("RAND()").limit(4).map{ |category| Product.find_by(category_id: category.id)}
    @items_kids = Category.where(large: "ベビー・キッズ").order("RAND()").limit(4).map{ |category| Product.find_by(category_id: category.id)}
    @items_cosmetics = Category.where(large: "コスメ・香水・美容").order("RAND()").limit(4).map{ |category| Product.find_by(category_id: category.id)}

    @items_chanel = Product.where(brand_id: '1').order("RAND()").limit(4)
    @items_vuitton = Product.where(brand_id: '2').order("RAND()").limit(4)
    @items_supreme = Product.where(brand_id: '3').order("RAND()").limit(4)
    @items_nike = Product.where(brand_id: '4').order("RAND()").limit(4)
  end
end
