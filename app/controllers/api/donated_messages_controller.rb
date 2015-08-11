module Api
  class DonatedMessagesController < ApplicationController
    #include HeaderAuthenticationConcern
    def index
      current_profile = Profile.last
      donated_messages = MessageDeliveries::DonatedMessage.joins([:donor, :message_delivery]).
        where(profiles: { id: current_profile.id }).
        where(message_deliveries: { status: MessageDeliveries::MessageDelivery.statuses[:not_sent] }).
        where("message_deliveries.created_at > ?", DateTime.now - 7.days)

      render json: donated_messages
    end

    def mark_as_sent
      donated_messages = MessageDeliveries::DonatedMessage.find(params[:id])
      donated_messages.sent! if donated_messages.donor_id == current_profile.id
      head 200
    end
  end
end
