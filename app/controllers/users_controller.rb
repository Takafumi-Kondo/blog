class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = if params[:search]
      User.page(params[:page]).per(10).where('name LIKE ?', "%#{params[:search]}%")
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
    #binding.pry
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
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_headerimage, :profile_image, :introduction)
  end
end
#binding.pry