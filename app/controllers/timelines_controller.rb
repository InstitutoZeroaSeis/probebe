class TimelinesController < ApplicationController
  before_action :authenticate_user!
  before_action :deny_admin_site_user_access_on_public_site
  before_action :check_profile_status

  def show
    @timeline = Timeline.new find_deliveries
    @timeline_step = TimelineStep.new
  end

  protected

  def find_deliveries
    child = Child.find(params[:id])
    MessageDeliveryTimelineDecorator.from_child(child).order_by_delivery_date.includes(:message)
  end
end
