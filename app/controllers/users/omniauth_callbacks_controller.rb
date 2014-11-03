class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def authenticate_user
    build_hash
    begin
      User.transaction do
        find_or_create_user
        find_or_create_profile
      end
      @user.skip_confirmation!
      sign_in_and_redirect @user, event: :authentication
    rescue ActiveRecord::RecordInvalid => e
      flash[:notice] = I18n.t('controller.messages.could_not_sign_up_with_omniauth')
      redirect_to new_user_session_path
    end
  end

  alias_method :google_oauth2, :authenticate_user
  alias_method :facebook, :authenticate_user

  def build_hash
    @omni_auth_hash = ::OmniAuthHashWrapper.new(request.env['omniauth.auth'])
  end

  def find_or_create_user
    @user = User.find_or_create_by!(email: @omni_auth_hash.email)
  end

  def find_or_create_profile
    @profile = @user.profile || Profile.create!(profile_attributes)
    if @omni_auth_hash.photo_url
      @profile.update_avatar_from_url(@omni_auth_hash.photo_url)
    end
  end

  def profile_attributes
    {
      first_name: @omni_auth_hash.first_name,
      last_name: @omni_auth_hash.last_name,
      gender: @omni_auth_hash.gender,
      user: @user
    }
  end

end
