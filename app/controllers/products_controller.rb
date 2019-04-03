class ProductsController < ApplicationController

  add_breadcrumb 'メルカリ', '/'
  add_breadcrumb 'マイページ', :users_path
  add_breadcrumb '出品した商品-出品中', :sells_path
  before_action :set_product, except: [:create, :index]
  before_action :get_header_category_brand, only: [:index, :show]
  before_action :authenticate_user!, only: [:create, :edit, :update, :remove]



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

  def create

    @product = Product.new(sell_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to root_path }
      else
        format.json { render template: 'sells/index', locals: {product: @product} }
      end
    end

  end

  def show
    @six_products_related_product = @product.six_products_related_product
    @six_products_related_user = Product.where(user_id: @product.user_id).limit(6)

    add_breadcrumb @product.name
  end

  def edit
    @middle_category_number = Category.find(@product.category_id).parent_id
    @large_category_number = Category.find(@middle_category_number).parent_id
    @shippingmethod_number = @product.delivary_option.shippingmethod_id
    @product_images = @product.product_images
    @images_count = @product_images.count
    @images_area_count = 5 - @images_count
    @images_area_count.times { @product.product_images.build }
    respond_to do |format|
      format.html
      format.json { @middle_categories = Category.find(params[:category_id]).children }
    end
  end

  def update
    respond_to do |format|
      if @product.update(sell_params)
        format.html { redirect_to root_path }
      else
        format.json { render template: 'sells/index', locals: {product: @product} }
      end
    end
  end

  def remove
    respond_to do |format|
      format.html
      format.json { ProductImage.find(params[:image_id]).delete }
    end
  end


  private

  def category_search(category_name)
    ActiveRecord::Base.connection.select_all(create_get_category_SQL(category_name)).to_hash.map{|id| Product.find( id.fetch("id") )}
  end

  def brand_search(brand_id)
    Product.where(brand_id: brand_id).order("RAND()").limit(4)
  end

  def get_category_SQL(low, high)
    ActiveRecord::Base.connection.select_all("SELECT products.id FROM `products` LEFT OUTER JOIN `categories` ON `categories`.`id` = `products`.`category_id` WHERE `products`.`category_id` BETWEEN #{low} AND #{high}  ORDER BY RAND() LIMIT 4").to_hash.map{|id| Product.find( id.fetch("id") )}
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.permit(:name, :price)
  end

  def sell_params
    params.require(:product).permit(:id, :name, :price, :category_id, :brand_id, :description, :state_id, delivary_option_attributes: [:shippingpay_id, :seller_fee, :purchaser_fee, :prefecture_id, :shippingday_id], product_images_attributes: [:id, :image]).merge(user_id: current_user.id)
  end

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
