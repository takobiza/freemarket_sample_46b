class CommentsController < ApplicationController

  protect_from_forgery :except => [:destroy]

  def create
    @comment = Comment.new(comments_params)
    if @comment.save
      flash[:success] = "コメントしました"
    end

    redirect_to product_path(params[:product_id]), flash: {error: @comment.errors.full_messages}
  end

  def destroy
    Comment.delete(params[:id])
    flash[:success] = "削除しました"
    redirect_back(fallback_location: root_path)
  end

  private

  def comments_params
    params.require(:comment).permit(:message).merge(product_id: params[:product_id], user_id: current_user.id)
  end

end
