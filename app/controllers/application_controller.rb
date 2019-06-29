class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if current_user
      flash[:notice] = "ログインしました。"
      root_path
    else
    flash[:notice] = "ご登録ありがとうございます。登録完了いたしました。"
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました。"
    new_user_session_path
  end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
end
