class ProfilesController < ApplicationController
  before_action :get_header_category_brand
  before_action :authenticate_user!
  add_breadcrumb 'メルカリ', '/'
  before_action :no_use_turbolinks_cache, only: [:index]


  def index
    @user = User.find(current_user.id)
  end

  def save

    @user = User.find(current_user.id)
    if @user.update(profile_params)
      flash[:success] = "変更しました"
      redirect_to profiles_path
    else
      render :index
    end

  end

  def get_header_category_brand
    @brands = Brand.limit(5)

    @categories = Category.all
  end

  def profile_params
    params.require(:user).permit(:nickname, :message)
  end

end
