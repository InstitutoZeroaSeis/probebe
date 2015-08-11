module Api
  class DonatedMessagesController < ApplicationController
    include HeaderAuthenticationConcern
    def index
      donated_messages = MessageDeliveries::DonatedMessage.joins([:donor, :message_delivery]).
        where(profiles: { id: current_profile.id }).
        where(message_deliveries: { status: MessageDeliveries::MessageDelivery.statuses[:not_sent] }).
        where("message_deliveries.created_at > ?", DateTime.now - 7.days)

      render json: donated_messages
    end
  end
end
