class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @genres_data = Post.joins(:genre).where(user_id: params[:id])
    @emotions_data = Post.joins(:emotion).where(user_id: params[:id])
    @post_counts = Post.where(user_id: params[:id]).order(created_at: :ASC).group('date(created_at)').sum(:impressions_count)
    @new_posts = Post.where(user_id: params[:id]).page(params[:page]).per(6).reverse_order
    @post_pv_counts = Post.where(user_id: params[:id]).group(:impressions_count).order(impressions_count: "DESC").limit(5)
  #いいね数多い記事取得
    post_favorite_count = Post.joins(:favorites).where(user_id: params[:id]).group(:post_id).count
    post_favorited_ids = Hash[post_favorite_count.sort_by{ |_, v| -v }].keys
    @popular_posts = Post.where(id: post_favorited_ids)
    #@view_counts = Post.where(user_id: params[:id]).sum(:impressions_count)
    #product_favorite_count = Product.joins(:favorites).where(created_at: 1.weeks.ago..Time.now).group(:product_id).count
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
    @posts = if params[:search]
      @user.posts.page(params[:page]).per(10).where('body LIKE ?', "%#{params[:search]}%")
    else
      @user.posts.page(params[:page]).per(10).reverse_order
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  def destroy

    @user = User.find(params[:id])
    @user.destroy
=begin
    if current_user.admin?
        redirect_to users_path
    else
        redirect_to root_path
    end
=end
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
#binding.pry
