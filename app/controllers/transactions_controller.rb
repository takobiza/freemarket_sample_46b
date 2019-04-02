class TransactionsController < ApplicationController
  def index
    if current_user.pay_id.present?
      card_info = Payjp::Customer.retrieve(current_user.pay_id)[:cards][:data][0]
      @card_last4 = card_info[:last4]
      @card_exp_month = card_info[:exp_month]
      @card_exp_year = card_info[:exp_year]
    end
  end
end
