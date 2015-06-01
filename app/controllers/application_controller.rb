class ApplicationController < ActionController::Base
  impersonates :user
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to carnival_root_path, alert: exception.message
  end

  def user_for_paper_trail
    current_user.email if user_signed_in?
  end

  def current_profile
    current_user.profile if current_user
  end
  helper_method :current_profile

  def deny_site_user_access_on_admin
    return if current_user && !current_user.site_user?
    redirect_to root_path
  end

  private

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.site_user?
      root_path
    else
      carnival_root_path
    end
  end
end
