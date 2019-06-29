class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインされました。"
    root_path
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
