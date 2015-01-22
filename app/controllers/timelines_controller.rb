class TimelinesController < ApplicationController
  load_and_authorize_resource class: "Child"

  before_action :authenticate_user!
  before_action :deny_admin_site_user_access_on_public_site
  before_action :check_profile_status

  def show
    child = Child.find(params[:id])
    deliveries = MessageDeliveryTimelineDecorator.from_child(child)
    @timeline = Timeline.new deliveries
    @timeline_step = TimelineStep.new
  end
end
