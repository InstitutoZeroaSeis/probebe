
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def authenticate_user
    build_hash
    User.transaction do
      find_or_create_user
      find_or_create_profile
      find_or_create_personal_profile
      create_profile_avatar
    end

    if @new_personal_profile
      @user.skip_confirmation!
      sign_in @user
      redirect_to edit_personal_profile_path(@personal_profile)
    else
      sign_in_and_redirect @user, event: :authentication
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
    @profile = @user.profile || @user.create_profile!
  end

  def find_or_create_personal_profile
    if @profile.personal_profile
      @personal_profile = @profile.personal_profile
      @new_personal_profile = false
    else
      @personal_profile = @profile.create_personal_profile!(personal_profile_attributes)
      @new_personal_profile = true
    end
  end

  def create_profile_avatar
    if @new_personal_profile and @omni_auth_hash.photo_url
      @personal_profile.create_avatar!
      @personal_profile.avatar.from_url(@omni_auth_hash.photo_url)
      @personal_profile.avatar.save!
    end
  end

  def personal_profile_attributes
    {
      first_name: @omni_auth_hash.first_name,
      last_name: @omni_auth_hash.last_name,
      gender: @omni_auth_hash.gender
    }
  end

end

