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
    render :new
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
    post = Post.find_by(:id => params[:id])
    if direction == 1
      Vote.find_or_create_by!(
        :user_id => current_user.id,
        :votable_type => 'Post',
        :votable_id => post.id,
        :value => direction
      )
      redirect_to post_path(post.id) 
    else
      Vote.find_or_create_by!(
        :user_id => current_user.id,
        :votable_type => 'Post',
        :votable_id => post.id,
        :value => direction
      )
      redirect_to post_path(post.id)
    end
  end
  def posts_params
    params.require(:posts).permit(:title,:url, :content,:user_id,sub_ids: [])
  end

  def posts_params_edit
    params.require(:posts).permit(:url,:content)
  end
end
