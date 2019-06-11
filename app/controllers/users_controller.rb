class UsersController < ApplicationController
  def show
  end

  def index
    @users = User.page(params[:page]).per(10).reverse_order
  end

  def edit
  end

  def update
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


  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_headerimage, :profile_image, :introduction)
  end
end
