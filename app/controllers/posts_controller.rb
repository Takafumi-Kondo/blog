class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
  end

  def admin
    @posts = Post.page(params[:page]).per(20).reverse_order
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def timeline
    @user = current_user
    @users = @user.following.page(params[:page]).per(3).order("created_at DESC")
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :genre_id, :emotion_id, :impressions_count)
  end
end
#binding.pry