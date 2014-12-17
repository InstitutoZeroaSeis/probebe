class TimelinesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :deny_admin_site_user_access_on_public_site
  before_filter :check_profile_status

  def show
    @child = Child.find(params[:id])
    @deliveries = @child.message_deliveries.order_by_delivery_date
  end
end
