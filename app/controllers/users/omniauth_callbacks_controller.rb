class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def authenticate_user
    omniauth_user = Users::OmniauthUser.new(request.env['omniauth.auth'].info)
    @user = omniauth_user.find_or_create
    sign_in_and_redirect @user, event: :authentication
  end

  alias_method :google_oauth2, :authenticate_user
  alias_method :facebook, :authenticate_user
end
