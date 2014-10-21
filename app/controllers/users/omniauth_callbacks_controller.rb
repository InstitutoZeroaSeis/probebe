class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def authenticate_user
    build_user
    @user.skip_confirmation!
    @user.save
    sign_in_and_redirect @user, event: :authentication
  end

  def omniauth_info
    request.env['omniauth.auth'].info
  end

  def build_user
    omniauth_user = Users::OmniauthUser.new(omniauth_info)
    @user = omniauth_user.build_user
  end

  alias_method :google_oauth2, :authenticate_user
  alias_method :facebook, :authenticate_user
end
