class Admin::AdminController < Carnival::BaseAdminController
  def show_activity_log
    resource_class = self.class.resource_class
    @activity_log = PaperTrailViews::ActivityLog.new(resource_class, params[:id].to_i)
    render 'paper_trail/activity_log'
  end
end
