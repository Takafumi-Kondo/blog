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
    @user = User.find_by(id: @post.user)
    @page_views = @post.impressions_count
# 人気ランキング
    post_favorite_count = Post.joins(:favorites).where(user_id: @user).group(:post_id).count
    post_favorited_ids = Hash[post_favorite_count.sort_by{ |_, v| -v }].keys
    @popular_posts = Post.where(id: post_favorited_ids).limit(5)
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
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  def timeline
    @user = current_user
    @users = @user.following.all
    @timeline = Post.where(user_id: @users).order(created_at: :DESC).page(params[:page]).per(20)
  end

  def top
    @posts_pv_count = Post.page(params[:page]).group(:impressions_count).order(impressions_count: :DESC).limit(5)
# ジャンル別人気欄
    genre_post_count = Post.all.group(:genre_id).count
    genre_post_ids = Hash[genre_post_count.sort_by{ |_, v| -v }].keys
    @genre_popular_posts = Post.where(genre_id: genre_post_ids[0]).order(impressions_count: 'DESC').limit(4)
    @genre_popular_posts2 = Post.where(genre_id: genre_post_ids[1]).order(impressions_count: 'DESC').limit(4)
    @genre_popular_posts3 = Post.where(genre_id: genre_post_ids[2]).order(impressions_count: 'DESC').limit(4)
# ここまで
    popular_user_count = User.joins(:passive_relationships).group(:following_id).count
    popular_user_ids = Hash[popular_user_count.sort_by{ |_, v| -v }].keys
    @popular_users = User.where(id: popular_user_ids).limit(10)

    post_favorite_count = Post.joins(:favorites).group(:post_id).count
    post_favorited_ids = Hash[post_favorite_count.sort_by{ |_, v| -v }].keys
    @popular_posts = Post.where(id: post_favorited_ids)
    @posts = Post.page(params[:page]).per(10).reverse_order
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :genre_id, :emotion_id, :impressions_count, :post_headerimage)
  end
end
#binding.pry
