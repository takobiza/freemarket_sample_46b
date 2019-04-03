class PurchaseController < ApplicationController
  before_action :get_header_category_brand, only: [:edit, :update]
  before_action :authenticate_user!


  def edit
    @product = Product.find(params[:product_id])
    @purchase = Purchase.find_by(product_id: @product.id)
    if @purchase.buyer_id != current_user.id
      redirect_to root_path
    end
  end

  def update

    @purchase = Purchase.find_by(product_id: params[:product_id])
    if purchase_params[:is_product_arrived] == "1" && purchase_params[:rate].present?
      @purchase.rate = purchase_params[:rate]
      @purchase.save
      redirect_to users_path
    else

      if purchase_params[:is_product_arrived] == "0"
        @purchase.errors[:is_product_arrived] << " 商品が届いていたならチェックして下さい"
      else
        @purchase.is_product_arrived = purchase_params[:is_product_arrived]
      end

      if purchase_params[:rate].nil?
        @purchase.errors[:rate] << " 出品者を評価して下さい"
      else
        @purchase.rate = purchase_params[:rate]
      end

      @product = Product.find(params[:product_id])
      render :edit
    end
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

  def purchase_params
    params.require(:purchase).permit(:is_product_arrived, :rate)
  end

end
