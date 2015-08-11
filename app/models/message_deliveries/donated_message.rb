module MessageDeliveries
  class DonatedMessage < ActiveRecord::Base
    belongs_to :message_delivery
    belongs_to :donor, class_name: 'Profile'
  end
end