class ProductsController < ApplicationController

  add_breadcrumb 'メルカリ', '/'
  add_breadcrumb 'マイページ', :users_path
  add_breadcrumb '出品した商品-出品中', :sells_path
  before_action :set_product, except: [:create, :index, :switch]
  before_action :get_header_category_brand, only: [:index, :show, :switch]
  before_action :authenticate_user!, only: [:create,  :remove]
  before_action :no_use_turbolinks_cache, only: [:show]



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
    @comment = Comment.new
    @comments = Comment.where(product_id: params[:id]).includes(:user)
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
    if @product.brand_id.present?
      @brand_id = @product.brand_id
      @brand_name = Brand.find(@brand_id).name
    else
      @brand_id = ""
      @brand_name = ""
    end
    respond_to do |format|
      format.html
      format.json { @middle_categories = Category.find(params[:category_id]).children }
    end
  end


  def destroy
    product = Product.find(params[:id])
    if product.user_id == current_user.id
      product.destroy
      redirect_to root_path
    end
  end

  def switch
    @product = Product.find(params[:id])
    if @product.status
      @product.update(status: '0')
      flash[:success] = "出品停止しました"
    else
      @product.update(status: '1')
      flash[:success] = "出品再開しました"
    end
    redirect_to product_path(@product.id)
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
    Product.where(brand_id: brand_id).where(status: 1).order("RAND()").limit(4)
  end

  def get_category_SQL(low, high)
    ActiveRecord::Base.connection.select_all("SELECT products.id FROM `products` LEFT OUTER JOIN `categories` ON `categories`.`id` = `products`.`category_id` WHERE `products`.`category_id` BETWEEN #{low} AND #{high} AND  `products`.`status` = 1 ORDER BY RAND() LIMIT 4").to_hash.map{|id| Product.find( id.fetch("id") )}
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.permit(:name, :price, :status)
  end

  def sell_params
    params.require(:product).permit(:id, :name, :price, :category_id, :brand_id, :description, :state_id, delivary_option_attributes: [:shippingpay_id, :seller_fee, :purchaser_fee, :prefecture_id, :shippingday_id], product_images_attributes: [:id, :image]).merge(user_id: current_user.id)
  end

  def get_header_category_brand
    @brands = Brand.limit(5)

    @categories = Category.all
  end

end
