class CommentsController < ApplicationController
  def show
    @comment = Comment.friendly.find(params[:id])
    if params[:id] != @comment.slug
      return redirect_to @comment, :status => :moved_permanently
    end
  end
  def create
    @all_comments = Comment.all
    @comment = current_user.comments.new(comments_params)
    if @comment.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend("comments",
                  partial: "comments/comment",
                  locals: {:comment => @comment, :all_comments => @all_comments})
        end
      end
    else
      render :new
    end
  end

  def upvote
    vote(1)
  end
  def downvote
    vote(-1)
  end

  private
  def comments_params
    params.require(:comments).permit(:content, :author_id, :post_id,:parent_comment_id)
  end

  def vote(direction)
    @comment = Comment.find(params[:id])
    @vote = @comment.votes.find_or_initialize_by(user: current_user)

    unless @vote.update(value: direction)
      flash[:errors] = @vote.errors.full_messages
    end
    if @comment.parent_comment_id.present?
      redirect_to comment_path(@comment.parent_comment_id)
    else
      redirect_to post_path(@comment.post.id)
    end
  end
end
