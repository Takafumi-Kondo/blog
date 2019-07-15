class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :admin_user, only: [:index]

  def show
    @user = User.find(params[:id])
    @genres_data = Post.joins(:genre).where(user_id: params[:id])
    @emotions_data = Post.joins(:emotion).where(user_id: params[:id])
    @new_posts = Post.page(params[:page]).where(user_id: params[:id]).per(12).reverse_order
    @post_pv_counts = Post.where(user_id: params[:id]).group(:impressions_count).order(impressions_count: "DESC").limit(5)
  #いいね数多い記事取得
    post_favorite_count = Post.joins(:favorites).where(user_id: params[:id]).group(:post_id).count
    post_favorited_ids = Hash[post_favorite_count.sort_by{ |_, v| -v }].keys
    @popular_posts = Post.where(id: post_favorited_ids).limit(4)
  end

  def index
    @users = if params[:search]
      User.page(params[:page]).per(10).where('name LIKE ?', "%#{params[:search]}%").reverse_order
    else
      User.page(params[:page]).per(10).reverse_order
    end
  end

  def edit
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(20).reverse_order
    unless @user.id == current_user.id
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = '更新しました。'
      redirect_to user_path
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    if current_user.admin?
      redirect_to users_path
    else
      flash[:notice] = '退会しました。ご利用ありがとうございました。'
      redirect_to root_path
    end
  end

  def delete
    @user = User.find(params[:id])
    if @user.id == current_user.id
    elsif current_user.admin?
    else
      redirect_to root_path
    end
  end

  def timeline
    @user = User.find(params[:id])
    @users = @user.following.all
    @timeline = Post.page(params[:page]).where(user_id: @users).per(10).order(created_at: :DESC)
    unless @user.id == current_user.id
      redirect_to root_path
    end
  end

  def report
    user = User.find(params[:id])
    @total_pv = Post.where(user_id: user).sum(:impressions_count)
    @pv_counts = Post.where(user_id: user, created_at: 1.weeks.ago..Time.now).group('date(created_at)').sum(:impressions_count)
    @genres_data = Post.joins(:genre).where(user_id: user)
    @emotions_data = Post.joins(:emotion).where(user_id: user)
    unless user.id == current_user.id
      redirect_to root_path
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(20).reverse_order
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(20).reverse_order
    render 'show_follower'
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_headerimage, :profile_image, :introduction)
  end
end
