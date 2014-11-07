class ApplicationController < ActionController::Base
  impersonates :user
  before_filter :authenticate_user!
  protect_from_forgery with: :exception

  def current_profile
    current_user.profile if current_user
  end
  helper_method :current_profile

  def check_profile_status
    if user_signed_in?
      if profile_redirect_path
        flash[:notice] = I18n.t('controller.messages.complete_the_profile')
        redirect_to profile_redirect_path
      end
    end
  end

  def profile_redirect_path
    if current_profile.blank?
      new_profile_path
    elsif current_profile.invalid?
      edit_profile_path
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
