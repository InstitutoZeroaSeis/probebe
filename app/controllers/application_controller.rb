class ApplicationController < ActionController::Base
  impersonates :user
  before_filter :authenticate_user!
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to carnival_root_path, :alert => exception.message
  end

  def current_profile
    current_user.profile if current_user
  end
  helper_method :current_profile

  def check_profile_status
    if user_signed_in?
      redirect_to_profile(I18n.t('controller.messages.complete_the_profile'))
    end
  end

  def redirect_to_profile(flash_notice)
    if current_profile.blank?
      redirect_to new_profile_path, notice: flash_notice
    elsif current_profile.invalid?
      redirect_to edit_profile_path, notice: flash_notice
    end
  end

  def deny_site_user_access_on_admin
    if user_signed_in?
      redirect_to root_path if current_user.site_user?
    end
  end

  def deny_admin_site_user_access_on_public_site
    if user_signed_in?
      redirect_to carnival_root_path unless current_user.site_user?
    end
  end
end
