module MessageDeliveries
  class MessageDelivery < ActiveRecord::Base
    include Carnival::ModelHelper

    belongs_to :message, class_name: "Message"
    belongs_to :child, class_name: "Child"
    delegate :profile, to: :child

    enum status: [:not_sent, :sent, :failed]

    before_save :set_defaults

    scope :order_by_delivery_date, -> { order(delivery_date: :desc) }
    scope :created_today, -> { where(created_at: Date.today.beginning_of_day..Date.today.end_of_day) }

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
      child.profile.primary_cell_phone_number
    end

    protected

    def set_defaults
      self.status ||= :not_sent
    end

  end
end
