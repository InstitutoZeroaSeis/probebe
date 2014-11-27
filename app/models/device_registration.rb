class DeviceRegistration < ActiveRecord::Base
  validates_presence_of :platform, :platform_code
end
