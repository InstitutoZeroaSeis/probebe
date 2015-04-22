module MessageDeliveries
  class MessageDelivery < ActiveRecord::Base
    include Carnival::ModelHelper

    belongs_to :message, class_name: "Message"
    belongs_to :child, class_name: "Child"
    has_and_belongs_to_many :device_registrations
    has_one :profile, through: :child
    delegate :text, to: :message

    enum status: [:not_sent, :sent, :failed]

    before_save :set_defaults
    before_update :update_delivery_date

    scope :order_by_delivery_date, -> { order(delivery_date: :desc) }
    scope :created_today, -> { where(created_at: Date.today.beginning_of_day..Date.today.end_of_day) }
    scope :created_in_a_month, -> { where(created_at: 1.month.ago.beginning_of_day..Date.today.end_of_day) }
    scope :delivered_in_period, lambda { |period| where(delivery_date: period) }

    def article
      message.messageable
    end

    protected

    def set_defaults
      self.status ||= :not_sent
    end

    def update_delivery_date
      if status_changed? and status == 'sent'
        self.delivery_date = DateTime.now
      end
    end

  end
end
