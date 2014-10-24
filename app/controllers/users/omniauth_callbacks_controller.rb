class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def authenticate_user
    build_hash
    build_user
    build_profile
    build_personal_profile

    if !@personal_profile.persisted?
      @user.skip_confirmation!
      sign_in_and_redirect @user, event: :authentication
    else
      sign_in @user
      render 'personal_profiles/edit', locals: { profile: @personal_profile }
    end
  end

  alias_method :google_oauth2, :authenticate_user
  alias_method :facebook, :authenticate_user

  def build_hash
    @omni_auth_hash = ::OmniAuthHashWrapper.new(request.env['omniauth.auth'])
  end

  def build_user
    @user = User.find_by(email: @omni_auth_hash.email) ||
      User.create(email: @omni_auth_hash.email)
  end

  def build_profile
    @profile = @user.profile || @user.create_profile!
  end

  def build_personal_profile
    @personal_profile = @profile.personal_profile ||
      @profile.build_personal_profile(personal_profile_attributes)
  end

  def personal_profile_attributes
    {
      first_name: @omni_auth_hash.first_name,
      last_name: @omni_auth_hash.last_name,
      gender: @omni_auth_hash.gender
    }
  end

end
