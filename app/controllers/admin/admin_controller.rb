class Admin::AdminController < Carnival::BaseAdminController
  before_action :authenticate_user!
  before_action :deny_site_user_access_on_admin
  layout "carnival/admin"

  def show_activity_log
    resource_class = self.class.resource_class
    @activity_log = PaperTrailViews::ActivityLog.new(resource_class, params[:id].to_i)
    render 'paper_trail/activity_log'
  end
end
