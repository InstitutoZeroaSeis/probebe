module MessageDeliveries
  class MessageDelivery < ActiveRecord::Base
    include Rails.application.routes.url_helpers
    include Carnival::ModelHelper

    belongs_to :message, class_name: "Message"
    belongs_to :child, class_name: "Child"

    def article
      message.messageable
    end

    def send_message
      unless self.message_for_test
        send_message_to_device
      end
    end

    def profile_id
      child.profile.id
    end

    def profile_name
      child.profile.name
    end

  end
end
