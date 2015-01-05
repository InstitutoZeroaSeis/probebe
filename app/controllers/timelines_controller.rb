class TimelinesController < ApplicationController
  before_action :authenticate_user!
  before_action :deny_admin_site_user_access_on_public_site
  before_action :check_profile_status

  def show
    @child = Child.find(params[:id])
    @deliveries = @child.message_deliveries.order_by_delivery_date
  end
end
