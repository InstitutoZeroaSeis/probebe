class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :authenticate_user!

  def authenticate_user
    build_hash
    User.transaction do
      find_or_create_user
      find_or_create_profile
    end
    if @user.change_omniauth_password?
      sign_in_and_redirect @user, event: :authentication
    else
      sign_in @user
      redirect_to edit_profile_path
    end
  rescue ActiveRecord::RecordInvalid
    flash[:notice] =
      I18n.t('controller.messages.could_not_sign_up_with_omniauth')
    redirect_to new_user_session_path
  end
  alias_method :google_oauth2, :authenticate_user
  alias_method :facebook, :authenticate_user

  def failure
    p "============================="
    p failure_message
    set_flash_message :alert, :failure, kind: OmniAuth::Utils.camelize(failed_strategy.name), reason: failure_message
    flash[:notice] = " #{failure_message} ====== #{OmniAuth::Utils.camelize(failed_strategy.name)}"
    redirect_to after_omniauth_failure_path_for(resource_name)
  end

  protected

  def build_hash
    @omni_auth_hash = ::OmniAuthHashWrapper.new(request.env['omniauth.auth'])
  end

  def find_or_create_user
    @user = User.find_by(email: @omni_auth_hash.email) || create_user
  end

  def create_user
    create_with_password = Users::CreateUserWithRandomPassword.new(
      email: @omni_auth_hash.email,
      change_omniauth_password: false
    )
    create_with_password.save
    create_with_password.user
  end

  def find_or_create_profile
    @user.profile ||= Profile.create!(profile_attributes)
    return unless @omni_auth_hash.photo_url
    @user.profile.update_avatar_from_url(@omni_auth_hash.photo_url)
  end

  def profile_attributes
    {
      name: "#{@omni_auth_hash.first_name} #{@omni_auth_hash.last_name}",
      gender: @omni_auth_hash.gender,
      user: @user
    }
  end
end
