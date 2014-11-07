class TimelinesController < ApplicationController
  before_filter :check_profile_status

  def show
    @deliveries = current_profile.message_deliveries
  end
end
