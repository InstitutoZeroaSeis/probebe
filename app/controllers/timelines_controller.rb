class TimelinesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :deny_admin_site_user_access_on_public_site
  before_filter :check_profile_status

  def show
    @deliveries = current_profile.children.first.message_deliveries
    respond_to do |format|
      format.html
      format.json { render json: @deliveries.as_json(include: :message) }
    end
  end
end
