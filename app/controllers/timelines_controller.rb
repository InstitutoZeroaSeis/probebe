class TimelinesController < ApplicationController
  def show
    @messages = current_profile.message_deliveries
  end
end
