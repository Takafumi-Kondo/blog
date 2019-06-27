class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :timeline]
  before_action :admin_user, only: [:admin]
  impressionist :actions=>[:show]#Pvカウント

  def new
    @post = Post.new
    @post.postimages.build
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "投稿しました。"
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "失敗しました。必要項目を入力してください。"
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
    if @post.user_id != current_user.id
      redirect_to root_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "更新しました。"
      redirect_to post_path
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    if current_user.admin?
      flash[:notice] = "削除しました。"
      redirect_to posts_admin_path
    else
      user = User.find_by(id: post.user)
      flash[:notice] = "削除しました。"
      redirect_to edit_user_path(user)
    end
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
    @posts = Post.page(params[:page]).per(9).reverse_order
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :genre_id, :emotion_id, :impressions_count, :post_headerimage)
  end
end
#binding.pry
