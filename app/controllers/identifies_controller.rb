class IdentifiesController < ApplicationController
  before_action :get_header_category_brand, only: [:index, :update]
  before_action :authenticate_user!

  def index
    @user_detail = UserDetail.find(current_user.id);
  end

  def update
    @user_detail = UserDetail.find(current_user.id)
    @user_detail.update(user_detail_param)
    render :index
  end

  private
  def user_detail_param
    params.require(:user_detail).permit(:postal_code, :prefecture_id, :city, :block, :building)
  end

  def get_header_category_brand
    @brands = Brand.limit(5)

    @categories = Category.all
  end
end
