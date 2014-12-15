class Admin::SiteUsersController < Admin::AdminController
  layout "carnival/admin"

  skip_before_filter :deny_site_user_access_on_admin, only: [:stop_impersonating]
  load_and_authorize_resource 'User', except: :stop_impersonating
  defaults :resource_class => User

  def table_items
    User.site_user
  end

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

end