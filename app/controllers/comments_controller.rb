class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comments_params)
    redirect_to product_path(params[:product_id]), flash: {error: @comment.errors.full_messages}
  end

  private

  def comments_params
    params.require(:comment).permit(:message).merge(product_id: params[:product_id], user_id: current_user.id)
  end

end
