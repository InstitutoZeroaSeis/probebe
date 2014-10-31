class ApplicationController < ActionController::Base
  impersonates :user

  before_filter :authenticate_user!
  before_filter :check_profile_status

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_profile
    current_user.profile
  end

  def check_profile_status
    if current_user
      if current_profile.mother_profile.blank?
        flash[:notice] = I18n.t('controller.messages.complete_the_profile')
        redirect_to edit_mother_profile_path
      elsif current_profile.contact_profile.blank?
        flash[:notice] = I18n.t('controller.messages.complete_the_profile')
        redirect_to edit_contact_profile_path
      end
    end
  end
end
