class CardsController < ApplicationController
    protect_from_forgery except: :create
    before_action :get_header_category_brand
    before_action :set_api_key
    before_action :authenticate_user!

  def index
    if current_user.pay_id.present?
      card_info = Payjp::Customer.retrieve(current_user.pay_id)[:cards][:data][0]
      @card_last4 = card_info[:last4]
      @card_exp_month = card_info[:exp_month]
      @card_exp_year = card_info[:exp_year]
    end
  end

  def new
    @user = User.find(params[:user_id])
  end


  def create
    customer = Payjp::Customer.create(card: payjp_params[:payjpToken])
    @user = User.find(payjp_params[:user_id])
    @new_card = @user.update(pay_id: customer.id)

    if @new_card != nil
      redirect_to user_cards_path
    else
      redirect_to new_user_card_path
    end
  end

  def pay
    buy_product = Product.find(params[:products_id])
    charge = Payjp::Charge.create(
    amount: buy_product.price,
    customer: current_user.pay_id,
    currency: 'jpy'
   )

    if charge[:error].present?
      redirect_to product_transactions_path(buy_product.id)
    end

    if Purchase.create(product_id: buy_product.id, price_pay: charge[:amount], rate: 0, buyer_id: current_user.id, seller_id: buy_product.user_id)
      buy_product.update(is_buy: false)
    else
      redirect_to product_transactions_path(buy_product.id)
    end

    redirect_to users_path
  end

  def destroy
    card = User.find(params[:user_id])
    card.update!(pay_id: nil)
    redirect_to user_cards_path(current_user)
  end

  private
  def payjp_params
    params.permit(:payjpToken, :user_id)
  end

  def set_api_key
    Payjp.api_key = 'sk_test_cf22f826afb6315d068a24b2'
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


