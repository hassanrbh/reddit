class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comments_params)
    if @comment.save
      redirect_to post_path(@comment.post.id)
    else
      render :new
    end
  end
  private
  def comments_params
    params.require(:comments).permit(:content, :author_id, :post_id)
  end
end
