class IdentifiesController < ApplicationController
  before_action :get_header_category_brand
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
