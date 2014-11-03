class TimelinesController < ApplicationController
  def show
    @deliveries = current_profile.message_deliveries
  end
end
