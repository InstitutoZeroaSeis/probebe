class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def authenticate_user
    build_omniauth_user
    if @omniauth_user.save
      @user = @omniauth_user.user
      @user.skip_confirmation!
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = I18n.t('errors.messages.controllers.omniauth_callbacks.authenticate')
      redirect_to new_user_session_path
    end
  end

  def omniauth_info
    request.env['omniauth.auth'].info
  end

  def build_omniauth_user
    @omniauth_user = Users::OmniauthUser.new(omniauth_info)
  end

  alias_method :google_oauth2, :authenticate_user
  alias_method :facebook, :authenticate_user
end
