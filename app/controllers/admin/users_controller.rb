class Admin::UsersController < Carnival::BaseAdminController
  before_filter :authenticate_user!
  layout "carnival/admin"

  before_filter :deny_site_user_access_on_admin, except: :stop_impersonating
  after_filter :send_reset_password_email, only: [:create]
  load_and_authorize_resource 'User', except: :stop_impersonating

  def impersonate
    user = User.find(params[:id])
    impersonate_user(user)
    flash[:success] = I18n.t('success.controllers.admin.users.impersonate', user_name: current_user.email)
    render json: current_user
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
