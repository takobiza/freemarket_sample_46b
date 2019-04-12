class UsersController < ApplicationController
  before_action :get_header_category_brand
  before_action :authenticate_user!, except: [:new]
  add_breadcrumb 'メルカリ', '/'

  def index
    add_breadcrumb "マイページ"
    @user = User.find(current_user.id)
    @listing_number = Product.where(user_id: current_user.id).where(status: true).length
    purchase_buyer = @user.products_of_buyer
    @in_transaction = purchase_buyer.select{|product| product.purchase[0].rate == 0 }
    @old_transaction = purchase_buyer.select{|product| product.purchase[0].rate != 0 }
  end

  def new

  end

  def logout
  end

  def create
    render new
  end

  def listing
    @products = Product.where(user_id: current_user.id).where(is_buy: true)
  end

  def completed
    @products = current_user.products_of_seller.select{|product| product.purchase[0].rate != 0 && product.is_buy == false }
  end

  def in_progress
    @products = current_user.products_of_seller.select{|product| product.purchase[0].rate == 0 && product.is_buy == false }
  end

  def like
    @products = current_user.favorites.map{|favorite| Product.find(favorite.product_id)}
  end

  private
  def get_header_category_brand
    @brands = Brand.limit(5)

    @categories = Category.all
  end
end
