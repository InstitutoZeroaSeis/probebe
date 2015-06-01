class Admin::AdminSiteUsersController < Admin::AdminController
  layout 'carnival/admin'

  after_action :send_reset_password_email, only: [:create]
  skip_before_action :deny_site_user_access_on_admin
  load_and_authorize_resource 'User'

  defaults resource_class: User, instance_name: :user

  def table_items
    User.admin_site_user
  end

  def send_reset_password_email
    @user.send_reset_password_instructions if @user.valid?
  end

  def build_resource
    if action_name == 'create'
      create_user = Users::CreateUserWithRandomPassword.new(permitted_params[:user])
      create_user.save
      @user = create_user.user
    else
      super
    end
  end

  def edit_profile
    profile = User.find(params[:id]).profile
    redirect_to edit_admin_profile_path(profile)
  end

  private

  def permitted_params
    params.permit(user: [:email, :role, profile_attributes: [:name]])
  end
end
