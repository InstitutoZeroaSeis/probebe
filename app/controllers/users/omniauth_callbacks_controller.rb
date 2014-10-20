class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    provider_info = request.env['omniauth.auth'].info
    @user = User.find_by(email: provider_info.email)
    unless @user
      @user = User.create!(first_name: provider_info.first_name, last_name: provider_info.last_name, email: provider_info.email)
    end

    sign_in_and_redirect @user, event: :authentication
  end

  alias_method :facebook, :google_oauth2
end
