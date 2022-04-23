class PostsController < ApplicationController
  def show
    @post = Post.friendly.find(params[:id])
    @sub = Sub.friendly.find_by(:id => params[:sub_id])
    @comments_by_parent_id = @post.comments_by_parent_id

    if params[:id] != @post.slug
      return redirect_to @post, :status => :moved_permanently
    end
  end

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def create
    @post = current_user.posts.new(posts_params)

    if @post.save
      flash[:notice] = "Post Created Successfully ☄️"
      redirect_to post_path(@post.id)
    else
      flash[:error] = "Failed to Create Post"
      render :new
    end
  end

  def edit
    @post = Post.find_by(:id => params[:id])
    render :edit
  end

  def update
    @post = Post.find_by(:id => params[:id])

    if @post.update(posts_params)
      flash[:notice] = "Update Successfully"
      redirect_to post_path(@post.id)
    else
      flash[:error] = "Failed to Update"
      redirect_to post_path(@post.id)
    end
  end

  def downvote
    vote(-1)
  end

  def upvote
    vote(1)
  end

  private

  def vote(direction)
    @post = Post.find(params[:id])
    @vote = @post.votes.find_or_initialize_by(user: current_user)

    unless @vote.update(value: direction)
      flash[:errors] = @vote.errors.full_messages
    end
    redirect_to comment_path(@post.id)
  end

  def posts_params
    params.require(:posts).permit(:title,:url, :content,:user_id,sub_ids: [])
  end

  def posts_params_edit
    params.require(:posts).permit(:url,:content)
  end
end
