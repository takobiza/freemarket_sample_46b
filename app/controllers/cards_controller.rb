class CardsController < ApplicationController
    protect_from_forgery except: :create

  def index
    Payjp.api_key = 'sk_test_cf22f826afb6315d068a24b2'
    card_info = Payjp::Customer.retrieve(current_user.pay_id)[:cards][:data][0]

    @card_last4 = card_info[:last4]
    @card_exp_month = card_info[:exp_month]
    @card_exp_year = card_info[:exp_year]

  end

  def new
    @user = User.find(params[:user_id])
  end


  def create
    Payjp.api_key = 'sk_test_cf22f826afb6315d068a24b2'
    customer = Payjp::Customer.create(card: payjp_params[:payjpToken])
    @user = User.find(payjp_params[:user_id])
    @new_card = @user.update(pay_id: customer.id)
    # binding.pry
    if @new_card != nil
      redirect_to user_cards_path
    else
      redirect_to new_user_card_path
    end
  end

  private
  def payjp_params
    params.permit(:payjpToken, :user_id)
  end
end


