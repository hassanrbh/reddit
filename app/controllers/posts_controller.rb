class PostsController < ApplicationController
  def show
    @post = Post.find_by(:id => params[:id])
    render :show
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = current_user.post.new(posts_params)

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

    if @post.save
      flash[:notice] = "Update Successfully"
      redirect_to post_path(@post.id)
    else
      flash[:error] = "Failed to Update"
      redieect_to post_path(@post.id)
    end
  end

  private

  def posts_params
    params.require(:posts).permit(:title,:url, :content,:sub_id)
  end

  def posts_params_edit
    params.require(:posts).permit(:url,:content)
  end
end
