class PostsController < ApplicationController
  def show
    @post = Post.find_by(:id => params[:id])
    @sub = Sub.find_by(:id => params[:sub_id])
    @comments_by_parent_id = @post.comments_by_parent_id
    render :show
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

  private

  def posts_params
    params.require(:posts).permit(:title,:url, :content,:user_id,sub_ids: [])
  end

  def posts_params_edit
    params.require(:posts).permit(:url,:content)
  end
end
