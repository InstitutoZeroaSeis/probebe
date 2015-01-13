class Admin::AdminSiteUsersController < Admin::AdminController
  layout "carnival/admin"

  after_action :send_reset_password_email, only: [:create]
  skip_before_action :deny_site_user_access_on_admin
  load_and_authorize_resource 'User'

  defaults :resource_class => User

  def table_items
    User.admin_site_user
  end

  def send_reset_password_email
    if @user.valid?
      @user.confirm!
      @user.send_reset_password_instructions
    end
  end

  def build_resource
    if action_name == "create"
      @user = User.new(permitted_params[:user])
      @user.skip_confirmation! if @user.valid?
      @user
    else
      super
    end
  end

  def create_profile
    redirect_to controller: 'profiles', action: 'new',  id: params[:id]
  end

  def edit_profile
    profile = find_profile(params[:id])
    redirect_to controller: 'profiles', action: 'edit', id: profile.id
  end

  private

  def find_profile(id)
    User.find(id).profile
  end

  def permitted_params
    params.permit(user: [:email, :role]) || {}
  end

end
