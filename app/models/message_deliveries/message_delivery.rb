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

    def profile_id
      child.profile.id
    end

    def profile_name
      child.profile.name
    end

    def profile_cell_phone
      child.profile.primary_cell_phone
    end

  end
end
