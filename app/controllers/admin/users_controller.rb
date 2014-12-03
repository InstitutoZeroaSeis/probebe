class Admin::UsersController < Admin::AdminController
  layout "carnival/admin"

  after_filter :send_reset_password_email, only: [:create]
  skip_before_filter :deny_site_user_access_on_admin, only: [:stop_impersonating]
  load_and_authorize_resource 'User', except: :stop_impersonating
  defaults :resource_class => User

  def impersonate
    user = User.find(params[:id])
    impersonate_user(user)
    flash[:success] = I18n.t('success.controllers.admin.users.impersonate', user_name: current_user.email)
    redirect_to root_path
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to carnival_root_path
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

  def permitted_params
    params.permit(user: [:email, :role]) || {}
  end

end
