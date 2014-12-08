module MessageDeliveries
  class DeviceRegistration < ActiveRecord::Base
    belongs_to :profile
    validates_presence_of :platform, :platform_code
  end
end
