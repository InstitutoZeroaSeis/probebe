class TimelinesController < ApplicationController
  before_action :authenticate_user!
  before_action :deny_admin_site_user_access_on_public_site
  before_action :check_profile_status

  def show
    @child = Child.find(params[:id])
    @timeline = Timeline.new(@child)
    @timeline_step = TimelineStep.new
  end
end
