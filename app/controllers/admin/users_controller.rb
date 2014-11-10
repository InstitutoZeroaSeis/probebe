class Admin::UsersController < Carnival::BaseAdminController
  layout "carnival/admin"

  before_filter :deny_site_user_access_on_admin
  load_and_authorize_resource 'User'

  def impersonate
    user = User.find(params[:id])
    impersonate_user(user)
    flash[:success] = I18n.t('success.controllers.admin.users.impersonate', user_name: current_user.email)
    render json: current_user
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to root_path
  end

end
