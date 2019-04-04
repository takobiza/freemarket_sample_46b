class CategoriesController < ApplicationController
  def show
    # ビューを作る上で下記の変数を作成しておかないと、エラーが出てビューの仕上がり状態の確認ができないため、暫定的に空の配列とProductの適当な値を渡してあります。
    @categories = []
    @brands = []

    pre_products = Product.where('status = ?', '1').order('id DESC')
    @count = pre_products.count
    @products = pre_products.page(params[:page]).per(4)
    # 仮で設置した変数などここまで（@countはページネーションの判定に必要なので必ず入れてください。詳しくはsearchコントローラーのindexアクションの記述とコメントアウトを参照してください）
  end
end
