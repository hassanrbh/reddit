class CommentsController < ApplicationController
  def show
    @comment = Comment.friendly.find(params[:id])
    if params[:id] != @comment.slug
      return redirect_to @comment, :status => :moved_permanently
    end
  end
  def create
    @comment = current_user.comments.new(comments_params)
    if @comment.save
      redirect_to comment_path(@comment.parent_comment_id)
    else
      render :new
    end
  end
  private
  def comments_params
    params.require(:comments).permit(:content, :author_id, :post_id,:parent_comment_id)
  end
end
