class TimelinesController < ApplicationController
  before_filter :deny_admin_site_user_access_on_public_site
  before_filter :check_profile_status

  def show
    @deliveries = current_profile.message_deliveries
  end
end
