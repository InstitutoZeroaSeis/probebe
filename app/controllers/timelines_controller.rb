class TimelinesController < ApplicationController
  load_and_authorize_resource class: "Child"

  before_action :authenticate_user!
  before_action :deny_admin_site_user_access_on_public_site
  before_action :check_profile_status
  before_action :load_timeline

  def show
    period = MessageDeliveryTimelineDecorator.default_period
    @timeline = MessageDeliveryTimelineDecorator.timeline(@child, period)
  end

  def monthly
    month = DateTime.parse(params[:date])
    period = MessageDeliveryTimelineDecorator.month_period(month)
    @timeline = MessageDeliveryTimelineDecorator.timeline(@child, period)
    @timeline_month = TimelineMonth.new(month.to_date)

    respond_to do |format|
      format.js { }
    end
  end

  private

  def load_timeline
    @child = Child.find(params[:id])
    @timeline_step = TimelineStep.new
    @month_step = TimelineStep.new
  end

end
