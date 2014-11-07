class ApplicationController < ActionController::Base
  impersonates :user

  before_filter :authenticate_user!
  before_filter :check_profile_status

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
end
