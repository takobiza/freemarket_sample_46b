class ProfilesController < ApplicationController
  before_action :get_header_category_brand
  add_breadcrumb 'メルカリ', '/'

  def index
    @user = User.find(current_user.id)
  end

  def save

    @user = User.find(current_user.id)
    if @user.update(profile_params)
      flash.now[:success] = "変更しました"
      render :index
    else
      render :index
    end

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

  def profile_params
    params.require(:user).permit(:nickname, :message)
  end

end
