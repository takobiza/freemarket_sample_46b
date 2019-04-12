class FavoritesController < ApplicationController

  def create

    if !(user_signed_in?)
      render :js => "window.location = ' /users/sign_in'"
      respond_to do |format|
        format.js { flash[:error] = "いいね!をするにはログインが必要です。
アカウントをお持ちでない場合は上記の「新規会員登録」より会員登録をしてください。" }
      end
    else
      @favorite = Favorite.create(favorite_param)
      respond_to do |format|
        format.json {@flag = "like" }
      end
    end

  end

  def destroy
    @favorite = Favorite.find_by(favorite_param)
    @favorite.delete
    respond_to do |format|
      format.json
    end
  end

  private
  def favorite_param
    params.permit(:product_id).merge(user_id: current_user.id)
  end
end
