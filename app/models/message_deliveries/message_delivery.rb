module MessageDeliveries
  class MessageDelivery < ActiveRecord::Base
    include Rails.application.routes.url_helpers
    include Carnival::ModelHelper

    belongs_to :message, class_name: "Message"
    belongs_to :child, class_name: "Child"

    scope :order_by_delivery_date, -> { order(delivery_date: :desc) }

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

    def profile_cell_phone
      child.profile.cell_phones.first.full_number
    end

  end
end
