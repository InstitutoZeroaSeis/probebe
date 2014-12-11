module MessageDeliveries
  class DeviceRegistration < ActiveRecord::Base
    belongs_to :profile
    validates_presence_of :platform, :platform_code

    validates_uniqueness_of :platform_code, scope: :platform
  end
end
