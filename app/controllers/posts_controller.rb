class PostsController < ApplicationController
  #before_action :admin_user, only: [:admin]
  impressionist :actions=>[:show]

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
    @comment = Comment.new
    #impressionist(@post, nil, :unique => [:session_hash])
    @page_views = @post.impressions_count
    #binding.pry
  end

  def index
    @posts = if params[:search]
      Post.page(params[:page]).per(20).where('title LIKE ? OR body LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%").reverse_order
    else
      Post.page(params[:page]).per(20).reverse_order
    end
  end

  def admin
    @posts = if params[:search]
      Post.page(params[:page]).per(20).where('title LIKE ? OR body LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%").reverse_order
    else
      Post.page(params[:page]).per(20).reverse_order
    end
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
