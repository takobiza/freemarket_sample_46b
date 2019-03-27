class CardsController < ApplicationController
  protect_from_forgery except: :create

  def index
  end

  def new
    @user = User.find(params[:user_id])
  end


  def create
    Payjp.api_key = 'sk_test_cf22f826afb6315d068a24b2'
    customer = Payjp::Customer.create(card: params[:payjpToken])
    @user = User.find(params[:user_id])
    @new_card = @user.update(pay_id: customer.id)

    if @new_card != nil
      redirect_to root_path
    else
      redirect_to new_user_card_path
    end
  end

end

